import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wordpress/data/model/posts/post_model.dart';

class HomePostItem extends StatelessWidget {
  final PostModel item;
  const HomePostItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(left: 10, top: 5, bottom: 5),
      constraints: BoxConstraints(maxWidth: 500, maxHeight: 125),
      child: Stack(
        children: [
          Container(
            constraints: BoxConstraints(maxWidth: 500),
            child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                    side: BorderSide(color: Colors.transparent)
                ),
                margin: EdgeInsets.only(top: 15, left: 20),
                child: Padding(
                  padding: EdgeInsets.only(left: 100, top: 10, bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${item.title}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Expanded(
                        child: Container(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                '${item.category}',
                                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
                              ),
                            )
                        ),
                      ),
                      Row(
                        children: [
                          Icon(Icons.access_time_outlined, size: 12),
                          SizedBox(width: 5),
                          Text(
                              '${item.date}',
                              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 12)
                          )
                        ],
                      ),
                    ],
                  ),
                )
            ),
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
            ),

            child: ClipRRect(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              borderRadius: BorderRadius.circular(15),
              child: Container(
                color: Colors.white,
                height: 110,
                width: 110,
                child: Image.network('${item.image}', fit: BoxFit.cover),
              ),
            ),
          ),
        ],
      ),
    );
  }


}