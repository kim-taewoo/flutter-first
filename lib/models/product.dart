import 'package:flutter/material.dart'; // @required annotaion 을 위해 필요하다.

class Product {
  final String uid;
  final String title;
  final String description;
  final double price;
  final String image;
  final bool isFavorite;
  final String userEmail;
  final String userId;

  // flexibility 를 위해 named arguments 를 사용
  Product({
    @required this.uid,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.image,
    @required this.userEmail,
    @required this.userId,
    this.isFavorite = false,
  });
}
