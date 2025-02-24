import 'package:get/get.dart';
import 'package:wordpress/screen/category/category_screen.dart';
import 'package:wordpress/screen/comment/comment_screen.dart';
import 'package:wordpress/screen/post/post_screen.dart';
import '../screen/home/home_screen.dart';

class PageNavigation {

  static const String splash = '/';
  static const String home = '/home';
  static const String category = '/category=';
  static const String postDetails = '/post=';
  static const String postComment = '/comments=';


  static final routes = [
    //GetPage(name: splash, page: () => SplashScreen()),
    GetPage(name: home, page: () => HomeScreen()),
    GetPage(name: postDetails, page: () {
      final postId = Get.parameters['id'] ?? '0';
      return PostScreen(postId: postId);
    }),
    GetPage(name: postComment, page: () {
      final postId = Get.parameters['id'] ?? '0';
      return CommentScreen(postId: postId);
    }),
    GetPage(name: category, page: () {
      final catId = Get.parameters['id'] ?? '0';
      final name = Get.parameters['name'] ?? '';
      return CategoryScreen(id: catId, name: name,);
    })
  ];
}