import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:wordpress/data/model/comment/comment_model.dart';

class CommentItem extends StatelessWidget {

  final CommentModel? item;
  const CommentItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.all(15),
      child: Row(
        children: [
          CircleAvatar(
            radius: 32,
            backgroundImage: NetworkImage('${item!.author_avatar}'),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${item!.author_name}', style: TextStyle(fontWeight: FontWeight.bold)),
                  HtmlWidget(item!.comment.toString()),
                  Text('${item!.date}')
                ],
              ),
            )
          )
        ],
      ),
    );
  }



}