import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:wordpress/modules/controllers/home_controller.dart';
import 'package:wordpress/screen/home/item/home_post_item.dart';
import 'package:wordpress/utils/page_navigation.dart';

class HomePosts extends StatefulWidget {

  @override
  State<HomePosts> createState() => _HomePostsState();

}

class _HomePostsState extends State<HomePosts> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return RefreshIndicator(
      onRefresh: () async => setState(() {
        Provider.of<HomeController>(context, listen: false).pagingController.refresh();
      }),
      child: PagedListView<dynamic, dynamic>(
        scrollDirection: Axis.vertical,
        pagingController: Provider.of<HomeController>(context, listen: true).pagingController,
        builderDelegate: PagedChildBuilderDelegate(
            itemBuilder: (context, item, index) => GestureDetector(
              onTap: () {
                Get.toNamed('${PageNavigation.postDetails}', parameters: {'id' : item.id.toString()});
              },
              child: HomePostItem(item: item),
            )
        ),
      ),
    );
  }


}