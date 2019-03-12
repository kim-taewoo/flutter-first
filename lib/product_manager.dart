import 'package:flutter/material.dart';

import './products.dart';
import './product_control.dart';

class ProductManager extends StatefulWidget {
  final String startingProduct;

  // named argument 는 {} 을 써야 한다. 
  // optional(default) 값을 = 을 이용해서 넣을 수 있다.
  ProductManager({this.startingProduct = 'Sweets Tester'}) {
    print('[ProductManager Widget] Constructor');
  }

  @override
  State<StatefulWidget> createState() {
    print('[ProductManager Widget] createState()');
    return _ProductManagerState();
  }
}


class _ProductManagerState extends State<ProductManager> {
  List<String> _products = [];
     
  // initState() 가 아래의 build 보다 먼저 실행되기 때문에 
  // rerender 하는 데만 쓰이는 setState() 가 올 필요가 없다. 
  // 반면에 아래의 _addProduct 의 경우, 언제든 실행될 수 있기 때문에
  // setState() 를 통해서 추가해주게 된다. 
  @override
  void initState() {
    super.initState();
    print('[ProductManager State] initState()');
    // 연결된 위젯의 구성요소에 접근가능한 widget. 키워드는 State Object 에서 제공됨.
    _products.add(widget.startingProduct);
  }

  // 새로운 external data 를 받을 때마다 didUpdateWidget 이 실행된다. 
  // 여기같은 경우 main.dart 파일에서 받아오는 startingProduct 같은 external data
  // oldWidget 은 위에서 쓴 widget 과 비슷한 것이긴 한데,
  // 대신 이 oldWidget 은 updated 되기 전(새로운 외부 데이터 받아오기 전) 데이터를 지칭한다.
  // 그래서 뭐 필요하면 그걸 이용해서 서로 비교해도 되고
  // didUpdate 는 근데 맨 처음에도 발생되긴 한다. 처음도 update 긴 하니까?
  @override
  void didUpdateWidget(ProductManager oldWidget) {
    print('[ProductManager State] didUpdateWidget()');
    super.didUpdateWidget(oldWidget);
  }

  void _addProduct(String product) {
    setState(() {
      _products.add(product);
    });
  }

  @override
  Widget build(BuildContext context) {
    print('[ProductManager State] build()');
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(10.0),
          // 바로 실행시킬 게 아니라서 reference 만 보냄.
          child: ProductControl(_addProduct),
        ),
        Products(_products)
      ],
    );
  }
}
