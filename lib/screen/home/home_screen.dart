import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:wordpress/modules/controllers/home_controller.dart';
import 'package:wordpress/screen/home/widget/home_category_widget.dart';
import 'package:wordpress/screen/home/widget/home_posts.dart';
import 'package:wordpress/screen/home/widget/home_search_widget.dart';
import 'package:wordpress/utils/page_navigation.dart';

class HomeScreen extends StatefulWidget {

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final _drawerController = AdvancedDrawerController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<HomeController>(context, listen: false).getCategory();
    Provider.of<HomeController>(context, listen: false).createPage();
  }

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      backdrop: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: Theme.of(context).brightness == Brightness.light
                ? [Color(0xFFF6F6F6), Color(0xFFF6F6F6).withOpacity(0.2)]
                : [Color(0xFF26292A), Color(0xFF26292A).withOpacity(0.2)]
          )
        ),
      ),
      controller: _drawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      childDecoration: const BoxDecoration(
        borderRadius:  const BorderRadius.all(Radius.circular(16))
      ),
      drawer: drawerButtons(),
      child: Scaffold(
        body: Column(
          children: [
            Row(
              children: [
                IconButton(
                  icon: ValueListenableBuilder<AdvancedDrawerValue>(
                    valueListenable: _drawerController,
                    builder: (_, value, __) {
                      return AnimatedSwitcher(duration: Duration(milliseconds: 250),
                        child: Icon(
                            value.visible ? Icons.clear : Icons.menu,
                            key: ValueKey<bool>(value.visible)
                        ),
                      );
                    },
                  ),
                  onPressed: _handleMenuButton,
                  iconSize: 36,
                ),
                Expanded(child: HomeSearchWidget())
              ],
            ),
            HomeCategoryWidget(),
            SizedBox(height: 15),
            Expanded(child: HomePosts())
          ],
        ),
      ),
    );
  }

  
  void _handleMenuButton() {
    _drawerController.showDrawer();
  }
  
  drawerButtons(){
    return SafeArea(
      child: Container(
        child: ListTileTheme(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                children: [
                  Container(
                      width: 64.0,
                      height: 64.0,
                      margin: const EdgeInsets.only(
                        top: 24.0,
                        bottom: 12.0
                      ),
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.person)
                  ),
                  Text('Register')
                ],
              ),
              SizedBox(height: 8),
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    ListTile(
                      onTap: () {},
                      leading: Icon(Icons.home),
                      title: Text('Home'),
                    ),
                    ExpansionTile(
                      leading: Icon(Icons.category),
                      title: Text('Categories'),
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 20),
                          child: drawerCategoryItems(),
                        )
                      ],
                    ),
                    ListTile(
                      onTap: () {},
                      leading: Icon(Icons.settings),
                      title: Text('Settings'),
                    ),
                  ],
                ),
              ),
              DefaultTextStyle(
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white54,
                ),
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 16.0,
                  ),
                  child: Text(
                    'Developed by Berk Orhan | APPBeta Mobile',
                    style: TextStyle(color: Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  drawerCategoryItems() {
    final listCategory = Provider.of<HomeController>(context, listen: false).categoryModel;
    return ListView.builder(
      shrinkWrap: true,
      itemCount: listCategory.length-1,
      itemBuilder: (context, index) {
        var item = listCategory[index+1];
        return ListTile(
          onTap: () {
            Get.toNamed('${PageNavigation.category}', parameters: {'id':item.id.toString(), 'name': item.name.toString()});
          },
          leading: Icon(Icons.arrow_right_alt_outlined),
          title: Text('${item.name}'),
        );
      },
    );
  }

}