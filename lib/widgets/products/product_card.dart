import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

import './price_tag.dart';
import '../ui_elements/title_default.dart';
import '../../models/product.dart';
import '../../scoped-models/main.dart';

class ProductCard extends StatelessWidget {
  // final Map<String, dynamic> product;
  final Product product;
  final int productIndex;

  ProductCard(this.product, this.productIndex);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: ScopedModelDescendant<MainModel>(
          builder: (BuildContext context, Widget child, MainModel model) {
        return Column(
          children: <Widget>[
            InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () => Navigator.pushNamed<bool>(
                    context, '/product/' + model.allProducts[productIndex].uid),
                //   .then((bool value) {
                // if (value) {
                //   deleteProduct(index);
                // }
                // .push method 는 자바스크립트의 Promise 와 유사한 Future 를 리턴한다.
                // Future 는 어떤 waiting state Object 라고 할 수 있는데, 언젠가 일어날 것을 알기에 대기타고 있다가
                // 해당 이벤트가 일어나면 지정된 함수를 실행시킨다.
                // push에 마우스를 올렸을 때 뜨는 설명란의 <T> 는 generic type 를 뜻한다.
                // 즉 어떤 generic type 든 받아올 수 있으며, 지금 이 경우 bool 임을 push 뒤와 then 의 argument 에 적어준다.
                // print(value)
                // }),
                child: Column(
                  children: <Widget>[
                    FadeInImage(
                      image: NetworkImage(product.image),
                      height: 300.0,
                      fit: BoxFit.cover,
                      placeholder: AssetImage('assets/food.jpg'),
                    ),
                    Container(
                        padding: EdgeInsets.all(8),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              TitleDefault(product.title),
                              SizedBox(
                                width: 8.0,
                              ),
                              PriceTag(product.price.toString())
                            ])),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.5),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1.0),
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: Text('서울시 종로구 혜화동, 12-33'),
                    ),
                    Text(product.userEmail),
                  ],
                )),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: IconButton(
                icon: Icon(model.allProducts[productIndex].isFavorite
                    ? Icons.star
                    : Icons.star_border),
                color: Colors.amber,
                onPressed: () {
                  model.selectProduct(model.allProducts[productIndex].uid);
                  model.toggleProductFavoriteStatus();
                },
              ),
            )
          ],
        );
      }),
    );
  }
}
