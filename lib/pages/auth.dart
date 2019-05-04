import 'package:flutter/material.dart';

// 이 페이지를 만든 이유는, 라우팅을 했을 때 페이지 stack 을 쌓는 게 아니라 기존 페이지와 replace 하고 싶을 때가 있기 떄문이다.
// 예를 들어 로그인을 한 후에 뒤로가기 버튼을 눌렀을 때, 다시 로그인 페이지로 가고 싶지는 않지 않겠니?

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AuthPageState();
  }
}

class _AuthPageState extends State<AuthPage> {
  String _emailValue;
  String _passwordValue;
  bool _acceptTerms = false;

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550 ? 500.0 : deviceWidth * 0.95;

    return Scaffold(
      appBar: AppBar(title: Text('로그인')),
      body: Container(
        decoration: BoxDecoration(
            image:
                // image Widget 이 필요한 게 아니라서 Image.asset() 쓰지않고 AssetImage 로 경로만 알려줌
                DecorationImage(
          image: AssetImage('assets/background.jpg'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.5), BlendMode.dstATop),
        )),
        padding: EdgeInsets.all(10.0),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: targetWidth,
              child: Column(children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                      labelText: 'E-mail',
                      fillColor: Colors.white,
                      filled: true),
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (String value) {
                    setState(() {
                      _emailValue = value;
                    });
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextField(
                  decoration: InputDecoration(
                      labelText: 'Password',
                      fillColor: Colors.white,
                      filled: true),
                  obscureText: true,
                  onChanged: (String value) {
                    setState(() {
                      _passwordValue = value;
                    });
                  },
                ),
                SwitchListTile(
                    value: _acceptTerms,
                    onChanged: (bool value) {
                      setState(() {
                        _acceptTerms = value;
                      });
                    },
                    title: Text('Accept terms')),
                SizedBox(
                  height: 10.0,
                ),
                RaisedButton(
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                  child: Text('Login'),
                  onPressed: () {
                    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => ProductsPage()),);
                    Navigator.pushReplacementNamed(context, '/products');
                  },
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
