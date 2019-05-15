import 'dart:async';
// dart:async 원래 불러와야 되는데 주석처리해도 되는 거 보니 어떤 라이브러리에 포함이 된듯..?
// 하지만 구버전 flutter 에도 동작하게 하기 위해 꼭 import 해주어야 한다.
import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

import '../widgets/ui_elements/title_default.dart';
import '../models/product.dart';
import '../scoped-models/main.dart';

class ProductPage extends StatelessWidget {
  final Product product;

  ProductPage(this.product);

  _showWarningDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('정말 지울까요?'),
            content: Text('되돌릴 수 없습니다.'),
            actions: <Widget>[
              FlatButton(
                child: Text('취소'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                child: Text('확인'),
                onPressed: () {
                  Navigator.pop(context); // 이건 dialog 닫는 pop
                  Navigator.pop(context,
                      true); // 이건 기존 설정해둔 삭제하겠다는 true 값과 함께 products 페이지로 나가는 pop
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    // 전체 페이지(Scaffold) 를 감싸는 이 WillPopScope widget 은 자동으로 생성되는 back 버튼이나 기계의 뒤로가기 버튼이
    // 눌렸을 때의 행동을 준비하는 callback 을 등록한다(리스너 등록).
    return WillPopScope(
      onWillPop: () {
        // 이 onWillPop argument 는 뒤로가기를 통해 유저가 나갈 때 나가도록 허용할 것인지, 허용한다면 뭘 할 지의 함수 설정
        print('back button pressed');
        Navigator.pop(context, false);
        // 그냥 뒤로가기 눌렀을 때는 삭제하는 게 아니라서 false 를 가지고 나가게 함.
        return Future.value(false);
        // onWillPop 에 마우스를 올려보면, future 를 return 해야 함 을 알 수 있다.
        // 이 future 는 dart:async 를 import 해줘야 쓸 수 있다.
        // Future.value 로 현재스택(창)을 나가는 것과 Navigator.pop 으로 나가는 현재스택(창) 이 겹치면 이상한 오류가 발생한다.
        // 따라서 Navigator.pop 으로 이동할 것이라면 Future.value() 에는 false 값을 줘서 default action 을 막아주어야 한다.
        // 이 이상한 오류가 왜 생기냐면, Navigator.pop 도 화면 스택 맨 위에걸 없애는 거고, Future.value 도 없애는 거라 동시에 2개 없애려고 하는 뭐 그런 것 땜에 오류난다.
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(product.title),
        ),
        body: Center(
          // 사실 이미지 자체가 center 되는 위젯이기 때문에 이렇게 Center 로 감싸줄 필요 없지만 다른 데 응용하도록 남겨둠.
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              FadeInImage(
                image: NetworkImage(product.image),
                height: 300.0,
                fit: BoxFit.cover,
                placeholder: AssetImage('assets/food.jpg'),
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                child: TitleDefault(product.title),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('서울시 종로구 혜화동',
                      style: TextStyle(
                        fontFamily: 'Gyeonggi',
                        fontSize: 16,
                      )),
                  Container(
                    child: Text('|'),
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                  ),
                  Text('\$${product.price.toString()}',
                      style: TextStyle(
                        fontFamily: 'Gyeonggi',
                        fontSize: 16,
                      ))
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 30.0),
                height: 1.0,
                color: Colors.grey,
              ),
              Container(
                padding: EdgeInsets.all(18.0),
                child: Text(
                  product.description,
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
