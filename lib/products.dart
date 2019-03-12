import 'package:flutter/material.dart';

class Products extends StatelessWidget {
  final List<String> products;

  // named argument 와 달리 positional argument 의 optional(default) 값을 넣을 때는
  // {} 가 아닌 [] 로 감싸서 optional 값을 써준다. 
  Products([this.products = const []]) {
    print('[Products Widget] Constructor');
  }

  @override
  Widget build(BuildContext context) {
    print('[Products Widget] build()');
    return Column(
      children: products
          .map(
            (element) => Card(
                  child: Column(
                    children: <Widget>[
                      Image.asset('assets/food.jpg'),
                      Text(element)
                    ],
                  ),
                ),
          )
          .toList(),
    );
  }
}
