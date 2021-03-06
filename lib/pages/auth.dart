import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

import '../scoped-models/main.dart';

enum AuthMode { Signup, Login }

// 이 페이지를 만든 이유는, 라우팅을 했을 때 페이지 stack 을 쌓는 게 아니라 기존 페이지와 replace 하고 싶을 때가 있기 떄문이다.
// 예를 들어 로그인을 한 후에 뒤로가기 버튼을 눌렀을 때, 다시 로그인 페이지로 가고 싶지는 않지 않겠니?

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AuthPageState();
  }
}

class _AuthPageState extends State<AuthPage> {
  final Map<String, dynamic> _formData = {
    'email': null,
    'password': null,
    'acceptTerms': false
  };
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordTextController = TextEditingController();
  AuthMode _authMode = AuthMode.Login;

  Widget _buildEmailTextField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'E-Mail', filled: true, fillColor: Colors.white),
      keyboardType: TextInputType.emailAddress,
      validator: (String value) {
        if (value.isEmpty ||
            !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                .hasMatch(value)) {
          return 'Please enter a valid email';
        }
      },
      onSaved: (String value) {
        _formData['email'] = value;
      },
    );
  }

  Widget _buildPasswordTextField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Password', filled: true, fillColor: Colors.white),
      obscureText: true,
      controller: _passwordTextController,
      validator: (String value) {
        if (value.isEmpty || value.length < 6) {
          return 'Password invalid';
        }
      },
      onSaved: (String value) {
        _formData['password'] = value;
      },
    );
  }

  Widget _buildPasswordConfirmTextField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Confirm Password', filled: true, fillColor: Colors.white),
      obscureText: true,
      validator: (String value) {
        if (_passwordTextController.text != value) {
          return 'Password do not match';
        }
      },
    );
  }

  void _submitForm(Function login, Function signup) async {
    if (!_formKey.currentState.validate() || !_formData['acceptTerms']) {
      return;
    }
    _formKey.currentState.save();
    if (_authMode == AuthMode.Login) {
      login(_formData['email'], _formData['password']);
    } else {
      final Map<String, dynamic> successInformation =
          await signup(_formData['email'], _formData['password']);
      if (successInformation['success']) {
        Navigator.pushReplacementNamed(context, '/products');
      } else {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('An Error Occurred!'),
                content: Text(successInformation['message']),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Okay'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            });
      }
    }
  }

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
              child: Form(
                key: _formKey,
                child: Column(children: <Widget>[
                  // 이런식으로 위젯을 outsource 할 수도 있다.
                  _buildEmailTextField(),
                  SizedBox(
                    height: 10.0,
                  ),
                  _buildPasswordTextField(),
                  _authMode == AuthMode.Signup
                      ? Column(
                          children: <Widget>[
                            SizedBox(
                              height: 10.0,
                            ),
                            _buildPasswordConfirmTextField(),
                          ],
                        )
                      : Container(),
                  SwitchListTile(
                    value: _formData['acceptTerms'],
                    onChanged: (bool value) {
                      setState(() {
                        _formData['acceptTerms'] = value;
                      });
                    },
                    title: Text('Accept terms'),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  FlatButton(
                    child: Text(
                        'Switch to ${_authMode == AuthMode.Login ? 'Signup' : 'Login'}'),
                    onPressed: () {
                      setState(() {
                        _authMode = _authMode == AuthMode.Login
                            ? AuthMode.Signup
                            : AuthMode.Login;
                      });
                    },
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  ScopedModelDescendant<MainModel>(
                    builder:
                        (BuildContext context, Widget child, MainModel model) {
                      return model.isLoading
                          ? CircularProgressIndicator()
                          : RaisedButton(
                              color: Theme.of(context).primaryColor,
                              textColor: Colors.white,
                              child: Text(_authMode == AuthMode.Login
                                  ? 'LOGIN'
                                  : 'SIGNUP'),
                              onPressed: () =>
                                  _submitForm(model.login, model.signup),
                            );
                    },
                  )
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
