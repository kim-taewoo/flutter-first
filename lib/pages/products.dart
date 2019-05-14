import 'package:flutter/material.dart';

import '../widgets/products/products.dart';

// scoped-model 을 쓰게 되면서 product 가 이 page 에 있을 필요가 없어졌다.
// 애초에 데이터를 쓰는 곳은 Products Widget 이라서 그곳으로 보내는 경유지일 뿐이었기 때문.
// import '../models/product.dart';
// import '../product_manager.dart';
// import './products_admin.dart';

class ProductsPage extends StatelessWidget {
  // final List<Map<String, dynamic>> products;
  // final List<Product> products;
  // final Function addProduct;
  // final Function deleteProduct;

  // ProductsPage(this.products);


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
              leading: Icon(Icons.edit),
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
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.sort),
            onPressed: () {},  
          )
        ],
      ),
      // named argument 에 value 넘길 때 : 을 쓴다. python 과 달리 = 이 아냐!
      // body: ProductManager(startingProduct: 'Food Tester'),
      body: Products(),
    );
  }
}
