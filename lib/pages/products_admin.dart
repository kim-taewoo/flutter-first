import 'package:flutter/material.dart';

import './products.dart';
import './product_create.dart';
import './product_list.dart';

class ProductAdminPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: Drawer(
          child: Column(
            children: <Widget>[
              AppBar(
                automaticallyImplyLeading: false,
                title: Text('메뉴'),
                backgroundColor: Colors.blue,
              ),
              ListTile(
                title: Text('모든 상품 관리'),
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/');
                //   Navigator.pushReplacement(
                //       context,
                //       MaterialPageRoute(
                //           builder: (BuildContext context) => ProductsPage()));
                },
              )
            ],
          ),
        ),
        appBar: AppBar(
          title: Text('ProductAdminPage'),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.create),
                text: 'Create Product',
              ),
              Tab(
                icon: Icon(Icons.list),
                text: 'My Products',
              ),
            ],
          ),
        ),
        body: TabBarView(children: <Widget>[
          ProductCreatePage(),
          ProductListPage(),
        ],)
      ),
    );
  }
}
