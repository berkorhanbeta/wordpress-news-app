import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:wordpress/data/model/category/category_model.dart';
import 'package:wordpress/data/model/posts/post_model.dart';
import 'package:wordpress/data/model/search/search_model.dart';
import 'package:wordpress/utils/app_constant.dart';

class HomeController extends ChangeNotifier {

  Dio dio = Dio();

  List<CategoryModel> categoryModel = [];
  Future<void> getCategory() async {
    dio.options.headers = {};
    try {
      final response = await dio.get(AppConstant.wp_category);
      categoryModel = [];
      categoryModel = (response.data as List).map((v) => CategoryModel.fromJson(v)).toList();
      categoryModel.insert(0, CategoryModel());
      notifyListeners();
    } catch (e) {
      return;
    }
  }

  List<SearchModel> searchResult = [];
  Future<void> searchPost(String keyword) async {
    try {
      searchResult = [];
      final response = await dio.get(AppConstant.wp_search + keyword);
      searchResult = (response.data as List).map((v) => SearchModel.fromJson(v)).toList();
      notifyListeners();
    } catch (e) {
      searchResult = [];
      notifyListeners();
      return;
    }
  }







  final PagingController<int, PostModel> pagingController = PagingController(firstPageKey: 1);
  List<PostModel> postModel = [];
  int pageSize = 1;
  int catId = 0;

  Future<void> getPosts(int pageKey) async {
    try {
      final response;
      if(catId != 0){
        print(AppConstant.wp_posts + pageKey.toString() + '&categories=${catId}');
        response = await dio.get(AppConstant.wp_posts + pageKey.toString() + '&categories=${catId}');
      } else {
        print(AppConstant.wp_posts + pageKey.toString());
        response = await dio.get(AppConstant.wp_posts + pageKey.toString());
      }
      if(response.headers['x-wp-totalpages']![0].isNotEmpty){
        pageSize = int.parse(response.headers['x-wp-totalpages']![0].toString());
      }
      if(pageKey >= pageSize){
        pagingController.appendLastPage(
            (response.data as List).map((v) => PostModel.fromJson(v)).toList(),
        );
      } else {
        pagingController.appendPage(
            (response.data as List).map((v) => PostModel.fromJson(v)).toList(),
            pageKey+1
        );
      }
      notifyListeners();
    } catch (e) {}
  }

  Future<void> createPage() async {
    pagingController.addPageRequestListener((pageKey) async {
      await getPosts(pageKey);
    });
  }

  Future<void> changeCatId(id) async{
    catId = id;
    postModel = [];
    pagingController.refresh();
  }

}