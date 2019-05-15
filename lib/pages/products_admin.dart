import 'package:flutter/material.dart';

// import './products.dart';
import './product_edit.dart';
import './product_list.dart';
import '../scoped-models/main.dart';

class ProductAdminPage extends StatelessWidget {
  final MainModel model;

  ProductAdminPage(this.model);
  // final Function addProduct;
  // final Function updateProduct;
  // final Function deleteProduct;
  // // final List<Map<String, dynamic>> products;
  // final List<Product> products;

  // ProductAdminPage(this.addProduct, this.updateProduct, this.deleteProduct, this.products);

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
                  leading: Icon(Icons.shop),
                  title: Text('모든 상품 관리'),
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '/products');
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
              onTap: (int value) {
                FocusScope.of(context).detach();
              },
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
          body: GestureDetector(
            onTap: () {
              // FocusScope.of(context).requestFocus(FocusNode());
              // 위처럼 새로이 의미없는 오브젝트 생성하는 것보다 아래가 나을듯?
              FocusScope.of(context).detach();
            },
            child: TabBarView(
              children: <Widget>[
                ProductEditPage(
                  // addProduct: addProduct
                ),
                ProductListPage(
                  model
                    // products, updateProduct, deleteProduct
                ),
              ],
            ),
          )),
    );
  }
}
