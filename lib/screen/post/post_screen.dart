import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:wordpress/modules/controllers/post_controller.dart';
import 'package:wordpress/utils/app_constant.dart';
import 'package:wordpress/utils/page_navigation.dart';

class PostScreen extends StatefulWidget {

  final String postId;
  const PostScreen({super.key, required this.postId});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {

  Future<void> postDetails() async {
    await Provider.of<PostController>(context, listen: false).getPostDetails(widget.postId);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: FutureBuilder(
          future: postDetails(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if(snapshot.connectionState == ConnectionState.done){
              return Consumer<PostController>(
                builder: (context, postController, child) {
                  return SafeArea(
                    child: SingleChildScrollView(
                        child: Stack(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 3.2,
                              width: double.infinity,
                              child: Stack(
                                alignment: Alignment.topCenter,
                                children: [
                                  Align(
                                    alignment: Alignment.topCenter,
                                    child: Container(
                                      height: double.infinity,
                                      width: double.infinity,
                                      child: Image.network('${postController.postModel.image}', fit: BoxFit.fill),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: Icon(CupertinoIcons.back, size: 28, color: Colors.white),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: IconButton(
                                      onPressed: () {
                                        Share.share(
                                          '${postController.postModel.title}'
                                              '\n'
                                              '${AppConstant.base_url}/${postController.postModel.id.toString()}'
                                        );
                                      },
                                      icon: Icon(CupertinoIcons.link, size: 28, color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 3.7),
                                  padding: EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(45)
                                      ),
                                      color: Theme.of(context).brightness == Brightness.light
                                      ? Color(0xFFF6F6F6) : Color(0xFF26292A)
                                  ),
                                  child: Column(
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${postController.postModel.title}',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Row(
                                            children: [
                                              Row(
                                                children: [
                                                  const Icon(Icons.access_time_outlined, size: 12),
                                                  SizedBox(width: 5),
                                                  Text(
                                                      '${postController.postModel.date}',
                                                      style: TextStyle(fontWeight: FontWeight.normal, fontSize: 12)
                                                  )
                                                ],
                                              ),
                                              const Expanded(
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: [
                                                    Icon(Icons.comment_outlined, size: 12),
                                                    SizedBox(width: 5),
                                                    Text(
                                                        '0 Comment',
                                                        style: TextStyle(fontWeight: FontWeight.normal, fontSize: 12)
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                          Divider(),
                                          HtmlWidget(postController.postContent),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Container(
                                        height: 60,
                                        width: double.infinity,
                                        child: TextButton.icon(
                                            onPressed: () {
                                              Get.toNamed('${PageNavigation.postComment}', parameters: {'id': postController.postModel.id.toString()});
                                            },
                                            style: TextButton.styleFrom(
                                                backgroundColor: Colors.orange,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(6)
                                              )
                                            ),
                                            icon: Icon(Icons.comment_outlined, size: 24, color: Colors.white),
                                            label: Text(
                                                'See comments',
                                                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16, color: Colors.white)
                                            )
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                    ),
                  );
                },
              );
            } else {
              return Text('data');
            }
          },
        )
    );
  }
}