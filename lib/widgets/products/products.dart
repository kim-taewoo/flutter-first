import 'package:flutter/material.dart';

import './product_card.dart';

// import './pages/product.dart';

class Products extends StatelessWidget {
  final List<Map<String, dynamic>> products;
  // final Function deleteProduct;

  // named argument 와 달리 positional argument 의 optional(default) 값을 넣을 때는
  // {} 가 아닌 [] 로 감싸서 optional 값을 써준다.
  // Products([this.products = const []]) {

  // 아래처럼 argument 의 종류를 섞어서도 쓸 수 있다.. 신기방기
  // Products(this.products, {this.deleteProduct}) {
  //   print('[Products Widget] Constructor');
  // }

  Products(this.products) {
    print('[Products Widget] Constructor');
  }

  // Widget _buildProductItem(BuildContext context, int index) {
  //   return 카드 했던 것이지만 따로 widgets 로 만들면서 쓸모없어짐
  // }

  // ButtonBar(
  //   alignment: MainAxisAlignment.center,
  //   children: <Widget>[
  //     FlatButton(
  //       child: Text('Details'),
  //       onPressed: () => Navigator.pushNamed<bool>(
  //                   context, '/product/' + index.toString())
  //               .then((bool value) {
  //             if (value) {
  //               deleteProduct(index);
  //             }
  //             // .push method 는 자바스크립트의 Promise 와 유사한 Future 를 리턴한다.
  //             // Future 는 어떤 waiting state Object 라고 할 수 있는데, 언젠가 일어날 것을 알기에 대기타고 있다가
  //             // 해당 이벤트가 일어나면 지정된 함수를 실행시킨다.
  //             // push에 마우스를 올렸을 때 뜨는 설명란의 <T> 는 generic type 를 뜻한다.
  //             // 즉 어떤 generic type 든 받아올 수 있으며, 지금 이 경우 bool 임을 push 뒤와 then 의 argument 에 적어준다.
  //             // print(value)
  //           }),
  //     )
  //   ],
  // )

  Widget _buildProductList() {
    Widget productCards;
    if (products.length > 0) {
      // 아래처럼 ListView.builder 로 해줘야 모든 렌더링을 한꺼번에 다 해놓지 않고 화면에 필요할 때 맞춰서 효과적으로 렌더링해줌.
      productCards = ListView.builder(
        itemBuilder: (BuildContext context, int index) => ProductCard(products[index], index),
        itemCount: products.length,
      );
    } else {
      productCards = Container();
    }

    return productCards;
  }

  @override
  Widget build(BuildContext context) {
    print('[Products Widget] build()');
    return _buildProductList();
  }
}
