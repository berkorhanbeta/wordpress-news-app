import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordpress/modules/controllers/home_controller.dart';

class HomeCategoryWidget extends StatefulWidget {


  @override
  State<HomeCategoryWidget> createState() => _HomeCategoryWidgetState();
}

class _HomeCategoryWidgetState extends State<HomeCategoryWidget> {
  int isSelectedId = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder: (context, homeController, child) {
        final listCategory = homeController.categoryModel;
        if(listCategory.isNotEmpty){
          return Container(
            height: 50,
            margin: EdgeInsets.only(left: 15, right: 15),
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: listCategory.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                var item = listCategory[index];
                return Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: isSelectedId == index
                        ? Colors.orange : Theme.of(context).brightness == Brightness.light ? Color(0xFFF6F6F6) : Color(0xFF26292A),
                  ),
                  child: GestureDetector(
                    onTap: () async {
                      setState(() {
                        isSelectedId = index;
                      });
                      await homeController.changeCatId(item.id);
                    },
                    child: Text('${item.name}',
                    style: TextStyle(color: isSelectedId == index
                        ? Colors.white : Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white))
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(width: 10);
              },
            ),
          );
        } else {
          return SizedBox();
        }
      }
    );
  }
}