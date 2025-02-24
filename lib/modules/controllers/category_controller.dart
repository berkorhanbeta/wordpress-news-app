import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:wordpress/data/model/posts/post_model.dart';
import 'package:wordpress/utils/app_constant.dart';

class CategoryController extends ChangeNotifier {

  Dio dio = new Dio();
  List<PostModel> pm = [];
  Future<void> fetchCategoryPosts(String catId) async {
    pm = [];
    final response = await dio.get('${AppConstant.wp_category_posts}' + '${catId}');
    pm = (response.data as List).map((v) => PostModel.fromJson(v)).toList();
    notifyListeners();
  }

}