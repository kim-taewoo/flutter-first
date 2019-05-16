// import 'package:scoped_model/scoped_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';
import './connected_products.dart';

mixin UserModel on ConnectedProductsModel {
  void login(String email, String password) {
    authenticatedUser = User(id: 'dnxkq', email: email, password: password);
  }

  Future<Map<String, dynamic>> signup(String email, String password) async {
    isLoadingStatus = true;
    notifyListeners();    
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true,
    };
    final http.Response response = await http.post(
      'https://www.googleapis.com/identitytoolkit/v3/relyingparty/signupNewUser?key=AIzaSyAzaNDtZ8IQli_B4Siz6vamM6xXk5QEQmg',
      body: json.encode(authData),
      headers: {'Content-Type': 'application/json'},
    );
    final Map<String, dynamic> responseData = json.decode(response.body);
    bool hasError = true;
    String message = '뭔가 잘못되었네요 ㅠㅠ';
    if (responseData.containsKey('idToken')) {
      hasError = false;
      message = '회원가입 성공! 환영합니다!';
    } else if (responseData['error']['message'] == 'EMAIL_EXISTS') {
      message = 'This email already exists';
    }
    isLoadingStatus = false;
    notifyListeners();
    return {'success': !hasError, 'message': message};
  }
}
