import 'package:flutter/material.dart';
import 'package:lojavirtual/common/custom_drawer/custom_drawer.dart';
import 'package:lojavirtual/models/page_manager.dart';
import 'package:lojavirtual/screens/login/login_screen.dart';
import 'package:lojavirtual/screens/products/products_screen.dart';
import 'package:provider/provider.dart';

class BaseScreen extends StatelessWidget {

  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => PageManager(pageController),
      child: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Scaffold(
            drawer: CustomDrawer(),
            appBar: AppBar(

                title: Text('Home')
            ),
          ),
          ProductsScreen(),
          Scaffold(
            appBar: AppBar(
                title: Text('Home3')
            ),
            drawer: CustomDrawer(),
          ),
          Scaffold(
            appBar: AppBar(
                title: Text('Home4')
            ),
            drawer: CustomDrawer(),
          ),
        ],
      ),
    );
  }
}
