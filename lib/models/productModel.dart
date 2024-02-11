import 'package:flutter/material.dart';

class Product with ChangeNotifier{
  final  String id;
  final String name;
  final String description;
  final String url;
  final String price;
  bool isFavorite;
  
  Product({
  required this.id,
  required this.name,
  required this.description,
  required this.url,
  required this.price,
  this.isFavorite = false,
  });

  void toggleIconFavorite() {
  isFavorite = !isFavorite;
  notifyListeners();
}
}