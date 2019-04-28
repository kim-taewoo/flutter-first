import 'package:flutter/material.dart';
import './products.dart';

// 이 페이지를 만든 이유는, 라우팅을 했을 때 페이지 stack 을 쌓는 게 아니라 기존 페이지와 replace 하고 싶을 때가 있기 떄문이다.
// 예를 들어 로그인을 한 후에 뒤로가기 버튼을 눌렀을 때, 다시 로그인 페이지로 가고 싶지는 않지 않겠니?

class AuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('로그인')),
      body: Center(
        child: RaisedButton(
          child: Text('Login'),
          onPressed: () {
            // Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => ProductsPage()),);
            Navigator.pushReplacementNamed(context, '/');
          },
        ),
      ),
    );
  }
}
