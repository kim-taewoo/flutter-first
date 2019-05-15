import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

import '../widgets/products/products.dart';
import '../scoped-models/main.dart';

// scoped-model 을 쓰게 되면서 product 가 이 page 에 있을 필요가 없어졌다.
// 애초에 데이터를 쓰는 곳은 Products Widget 이라서 그곳으로 보내는 경유지일 뿐이었기 때문.
// import '../models/product.dart';
// import '../product_manager.dart';
// import './products_admin.dart';

class ProductsPage extends StatefulWidget {
  // final List<Map<String, dynamic>> products;
  // final List<Product> products;
  // final Function addProduct;
  // final Function deleteProduct;

  // ProductsPage(this.products);

  final MainModel model;

  ProductsPage(this.model);

  @override
  State<StatefulWidget> createState() {
    return _ProductsPageState();
  }
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  void initState() {
    widget.model.fetchProducts();
    super.initState();
  }

  Widget _buildProductsList() {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {
        Widget content = Center(child: Text('No Products Found!'));
        if (model.displayedProducts.length > 0 && !model.isLoading) {
          content = Products();
        } else if (model.isLoading) {
          content = Center(child: CircularProgressIndicator());
        }
        return RefreshIndicator(
          child: content,
          onRefresh: model.fetchProducts,
        );
      },
    );
  }

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
          ScopedModelDescendant<MainModel>(
            builder: (BuildContext context, Widget child, MainModel model) {
              return IconButton(
                icon: Icon(model.displayFavoritesOnly
                    ? Icons.favorite
                    : Icons.favorite_border),
                onPressed: () {
                  model.toggleDisplyMode();
                },
              );
            },
          )
        ],
      ),
      // named argument 에 value 넘길 때 : 을 쓴다. python 과 달리 = 이 아냐!
      // body: ProductManager(startingProduct: 'Food Tester'),
      body: _buildProductsList(),
    );
  }
}
