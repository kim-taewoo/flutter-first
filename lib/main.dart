import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
import 'package:scoped_model/scoped_model.dart';

import './pages/auth.dart';
import './pages/products_admin.dart';
import './pages/products.dart';
import './pages/product.dart';
import './models/product.dart';
import './scoped-models/products.dart';

// void main() => runApp(MyApp());
void main() {
  // debugPaintSizeEnabled = true;
  // debugPaintBaselinesEnabled = true;
  // debugPaintPointersEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  // 원래 'product_manager.dart' 에 있던 products 변수였지만, 이제 이 main 에서 라우팅을 위해 데이터를 종합 관리하기 위해
  // MyApp 도 StatefulWidget 으로 변경하고, products 변수를 여기서 만들어준다.

  // models 로 product 를 관리하게 되면서 아래와 같이 변형된다.
  // List<Map<String, dynamic>> _products = [];
  // List<Product> _products = []; // scoped-models 를 쓰게 되면서 이것도 옮긴다

  @override
  Widget build(BuildContext context) {
    return ScopedModel<ProductsModel>(
      model: ProductsModel(),
      child: MaterialApp(
        // debugShowMaterialGrid: true,
        theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.deepOrange,
          accentColor: Colors.deepPurple,
          buttonColor: Colors.deepPurple,
        ),
        // home: AuthPage(),
        routes: {
          // '/' 는 home 이랑 역할이 같아서 둘 중 하나는 없애줘야 제대로 작동한다.
          '/': (BuildContext context) => AuthPage(),
          '/products': (BuildContext context) => ProductsPage(
              // _products
              ),
          '/admin': (BuildContext context) => ProductAdminPage(
              // _addProduct, _updateProduct, _deleteProduct, _products
              ),
        },
        // Routing 에 데이터를 첨부해야할 경우 onGenerateRoute 를 쓴다. 위 routes에 등록되지 않은 것이어야만 가능.
        onGenerateRoute: (RouteSettings settings) {
          final List<String> pathElements = settings.name.split('/');
          if (pathElements[0] != '') {
            return null;
          }
          if (pathElements[1] == 'product') {
            final int index = int.parse(pathElements[2]);
            return MaterialPageRoute<bool>(
                builder: (BuildContext context) => ProductPage(index));
          }
          return null; // parsing 에 실패하면 아무 페이지도 불러오지 않는다.
        },
        // 예는 onGenerateRoute 같은 걸로 페이지 이동하는 게 실패하면 뭘 할 지를 말해준다. 404 페이지 같은 것.
        onUnknownRoute: (RouteSettings settings) {
          return MaterialPageRoute(
              builder: (BuildContext context) => ProductsPage());
        },
      ),
    );
  }
}
