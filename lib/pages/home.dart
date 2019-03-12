import 'package:flutter/material.dart';

import '../product_manager.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('EasyList'),
      ),
      // named argument 에 value 넘길 때 : 을 쓴다.
      // body: ProductManager(startingProduct: 'Food Tester'),
      body: ProductManager(),
    );
  }
}
