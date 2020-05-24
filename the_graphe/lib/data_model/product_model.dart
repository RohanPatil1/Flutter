import 'package:flutter/material.dart';

class Product {
  final int id;
  final String name;
  final String imgUrl;
  final String description;
  final String code;
  final String price;

  Product(
      {this.id,
      this.name,
      this.imgUrl,
      this.description,
      this.code,
      this.price});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      code: json['code'] as String,
      price: json['price'] as String,
      imgUrl: json['img'] as String,
    );
  }
}
