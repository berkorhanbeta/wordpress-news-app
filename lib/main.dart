import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:wordpress/modules/controllers/category_controller.dart';
import 'package:wordpress/modules/controllers/comment_controller.dart';
import 'package:wordpress/modules/controllers/home_controller.dart';
import 'package:wordpress/modules/controllers/post_controller.dart';
import 'package:wordpress/theme/dark_theme.dart';
import 'package:wordpress/theme/light_theme.dart';
import 'package:wordpress/utils/page_navigation.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeController()),
        ChangeNotifierProvider(create: (_) => PostController()),
        ChangeNotifierProvider(create: (_) => CommentContoller()),
        ChangeNotifierProvider(create: (_) => CategoryController())
      ],
      child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'WordPress Demo',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      getPages: PageNavigation.routes,
      initialRoute: PageNavigation.home,
      scrollBehavior:  const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse, PointerDeviceKind.touch, PointerDeviceKind.stylus,
          PointerDeviceKind.unknown
        }, scrollbars: false
      ),
    );
  }
}
