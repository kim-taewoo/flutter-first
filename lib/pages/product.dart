import 'dart:async';

import 'package:flutter/material.dart';

class ProductPage extends StatelessWidget {
  final String title;
  final String imageUrl;

  ProductPage(this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
        onWillPop: () {
          print('back button pressed');
          Navigator.pop(context, false);
          return Future.value(false);
          // Future.value 로 현재스택(창)을 나가는 것과 Navigator.pop 으로 나가는 현재스택(창) 이 겹치면 이상한 오류가 발생한다.
          // 따라서 Navigator.pop 으로 이동할 것이라면 Future.value() 에는 false 값을 줘서 default action 을 막아주어야 한다. 
        },
        child: Scaffold(
            appBar: AppBar(
              title: Text(title),
            ),
            body: Center(
              // 사실 이미지 자체가 center 되는 위젯이기 때문에 이렇게 Center 로 감싸줄 필요 없지만 다른 데 응용하도록 남겨둠.
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(imageUrl),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    child: Text(title),
                  ),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    child: RaisedButton(
                      color: Theme.of(context).accentColor,
                      child: Text(
                        '삭제',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () => Navigator.pop(context, true),
                    ),
                  )
                ],
              ),
            )));
  }
}
