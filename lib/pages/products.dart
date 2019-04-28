import 'package:flutter/material.dart';

import '../product_manager.dart';
// import './products_admin.dart';

class ProductsPage extends StatelessWidget {
  final List<Map<String, dynamic>> products;
  // final Function addProduct;
  // final Function deleteProduct;

  ProductsPage(this.products);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            AppBar(
              automaticallyImplyLeading: false,
              title: Text('메뉴'),
              backgroundColor: Colors.blue,
            ),
            ListTile(
              title: Text('상품 관리'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/admin');
              },
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('EasyList'),
      ),
      // named argument 에 value 넘길 때 : 을 쓴다. python 과 달리 = 이 아냐!
      // body: ProductManager(startingProduct: 'Food Tester'),
      body: ProductManager(products),
    );
  }
}
