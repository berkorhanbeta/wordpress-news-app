import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:wordpress/data/model/posts/post_model.dart';
import 'package:wordpress/utils/app_constant.dart';

class PostController extends ChangeNotifier {


  String postContent = '';
  PostModel postModel = new PostModel();
  Dio dio = new Dio();
  Future<void> getPostDetails(String postId) async {
    print(AppConstant.wp_post_details + '${postId}' + '?_embedded');
    var response = await dio.get(AppConstant.wp_post_details + '${postId}' + '?_embedded');
    postModel = PostModel.fromJson(response.data);
    print('${postModel.image}');

    response = await dio.get(postModel.image.toString());
    print('${response.data}');
    postModel.newImage = response.data['guid']['rendered']?.toString() ?? '';
    postContent = postModel.content.toString();
    notifyListeners();
  }

}