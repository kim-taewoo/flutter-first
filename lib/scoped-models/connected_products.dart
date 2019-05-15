import 'dart:convert';
import 'dart:async';

import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

import '../models/product.dart';
import '../models/user.dart';

mixin ConnectedProductsModel on Model {
  List<Product> products = [];
  String selProductId;
  User authenticatedUser;
  bool isLoadingStatus = false;
  // void _addProduct(Map<String, dynamic> productData) {

  Future<bool> addProduct(
      String title, String description, String image, double price) {
    isLoadingStatus = true;
    notifyListeners();
    final Map<String, dynamic> productData = {
      'title': title,
      'description': description,
      'image':
          'http://health.chosun.com/site/data/img_dir/2015/08/26/2015082601109_0.jpg',
      'price': price,
      'userEmail': authenticatedUser.email,
      'userId': authenticatedUser.id,
    };
    return http
        .post(
            'https://flutter-first-project-f49da.firebaseio.com/products.json',
            body: json.encode(productData))
        .then((http.Response response) {
          if (response.statusCode != 200 || response.statusCode != 201) {
            isLoadingStatus = false;
            notifyListeners();
            return false;
          }
      final Map<String, dynamic> responseData = json.decode(response.body);
      print(responseData);
      final Product newProduct = Product(
          uid: responseData['name'],
          title: title,
          description: description,
          image: image,
          price: price,
          userEmail: authenticatedUser.email,
          userId: authenticatedUser.id);
      products.add(newProduct);
      isLoadingStatus = false;
      notifyListeners();
      return true;
    }).catchError((error) {
      isLoadingStatus = false;
      notifyListeners();
      return false;
    });
  }
}

mixin UtilityModel on ConnectedProductsModel {
  bool get isLoading {
    return isLoadingStatus;
  } 
}