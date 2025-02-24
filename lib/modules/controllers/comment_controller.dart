import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:wordpress/data/model/comment/comment_model.dart';
import 'package:wordpress/utils/app_constant.dart';

class CommentContoller extends ChangeNotifier {

  List<CommentModel> comments = [];
  Dio dio = new Dio();

  Future<void> fetchComment(String postId) async {
    final response = await dio.get('${AppConstant.wp_post_comment} + ${postId}');
    comments = (response.data as List).map((v) => CommentModel.fromJson(v)).toList();
    notifyListeners();
  }

  Future<void> postComment(String comment, String postId, Function callBack) async {
    final response = await dio.post(
      AppConstant.wp_post_comment + postId,
      queryParameters: {
        'author_name':'Anonymous',
        'author_email':'uygulama@app.com',
        'content':'${comment}',
      },
    );

    if(response.data['status'].toString().isNotEmpty){
      callBack(true, response.data['status'].toString());
    } else {
      callBack(false, 'An error occur');
    }

    notifyListeners();
  }

}