import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:wordpress/modules/controllers/category_controller.dart';
import 'package:wordpress/screen/category/item/category_item.dart';
import 'package:wordpress/utils/page_navigation.dart';

class CategoryScreen extends StatefulWidget {
  String? id;
  String? name;
  CategoryScreen({super.key, required this.id, required this.name});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<CategoryController>(context, listen: false).fetchCategoryPosts(widget.id.toString());

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.name}'),
      ),
      body: Consumer<CategoryController>(
        builder: (context, categoryController, child) {
          final posts = categoryController.pm;
          return ListView.separated(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Get.toNamed('${PageNavigation.postDetails}', parameters: {'id' : posts[index].id.toString()});
                },
                child: CategoryItem(pm: posts[index]),
              );
            },
            separatorBuilder: (context, index){
              return Divider();
            },
          );
        },
      )
    );
  }
}