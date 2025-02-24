import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordpress/data/model/search/search_model.dart';
import 'package:wordpress/modules/controllers/home_controller.dart';

class HomeSearchWidget extends StatefulWidget {
  @override
  State<HomeSearchWidget> createState() => _HomeSearchWidgetState();
}

class _HomeSearchWidgetState extends State<HomeSearchWidget> {

  int? selectedIndex = 0;
  String? searchQery;

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder: (context, homeController, child) {
        return Container(
          margin: EdgeInsets.all(20),
          child: SearchAnchor(
            builder: (BuildContext context, SearchController controller) {
              return SearchBar(
                hintText: 'Search',
                controller: controller,
                padding: const MaterialStatePropertyAll<EdgeInsets>(
                  EdgeInsets.symmetric(horizontal: 16.0),
                ),
                onTap: () {
                  controller.openView();
                },
                leading: const Icon(Icons.search),
              );
            },
            suggestionsBuilder: (BuildContext context, SearchController controller) async {
              await homeController.searchPost(controller.text);

              return List<ListTile>.generate(homeController.searchResult.length, (int index) {
                final SearchModel item = homeController.searchResult[index];
                return ListTile(
                  title: Text(item.title ?? 'Unknown'),
                  onTap: () {
                    print('clicked ${item.title}');
                  },
                );
              });
            },
          ),
        );
      },

    );
  }

}