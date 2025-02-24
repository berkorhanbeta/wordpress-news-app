import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:wordpress/modules/controllers/comment_controller.dart';
import 'package:wordpress/screen/comment/item/comment_item.dart';

class CommentScreen extends StatefulWidget {
  final String? postId;
  const CommentScreen({super.key, required this.postId});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {

  final TextEditingController comment = TextEditingController();

  Future<void> comments() async {
    await Provider.of<CommentContoller>(context, listen: false).fetchComment(widget.postId.toString());
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Comments'),
      ),
      body: FutureBuilder(
        future: comments(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if(snapshot.connectionState == ConnectionState.done){
            return Consumer<CommentContoller>(
              builder: (context, commentController, child) {
                return Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        itemCount: commentController.comments.length,
                        itemBuilder: (context, index) {
                          var item = commentController.comments[index];
                          return CommentItem(item: item);
                        },
                        separatorBuilder: (context, index) {
                          return Divider();
                        },
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).brightness == Brightness.light
                            ? Color(0xFFF6F6F6) : Color(0xFF26292A)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: uiElements('Write a comment', comment),
                          ),
                          IconButton(
                            onPressed: () async {
                              await commentController.postComment(comment.text.toString(), widget.postId.toString(), callBack);
                            },
                            icon: Icon(CupertinoIcons.pencil_ellipsis_rectangle),
                            padding: EdgeInsets.only(right: 5),
                          ),
                        ],
                      ),
                    )
                  ],
                );
              },
            );
          } else {
            return Text('');
          }
        },
      ),
    );
  }

  uiElements(String hintText, TextEditingController controller){
    return Container(
      alignment: Alignment.center,
      height: 50,
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        color: Colors.transparent,
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            hintText: hintText,
            filled: true,
            fillColor: Colors.transparent,
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(32)
            )
        ),
      )
    );
  }


  void callBack(bool isSuccess, String message) async {
    setState(() {
      if (isSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Your comment status is : $message'),
        ));
        comment.clear();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(message),
        ));
      }
    });
  }


}