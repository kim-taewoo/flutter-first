import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';

import './product_manager.dart';

// void main() => runApp(MyApp());
void main() {
  // debugPaintSizeEnabled = true;
  // debugPaintBaselinesEnabled = true;
  // debugPaintPointersEnabled = true;
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // debugShowMaterialGrid: true,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.deepOrange,
        accentColor: Colors.deepPurple
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('EasyList'),
        ),
        // named argument 에 value 넘길 때 : 을 쓴다.
        body: ProductManager(startingProduct: 'Food Tester'),
      ),
    );
  }
}
