import 'package:flutter/material.dart';
import 'package:provider_app_1/models/productModel.dart';

class ProductsProvider with ChangeNotifier {
  final List<Product> productItems = [
    Product(
        id: '1001',
        name: 'Adidas Tobacco',
        description: 'null',
        url: '../assets/image/adidas-tobacco-gruen-shoes.png',
        price: '200000'),
    Product(
        id: '1002',
        name: 'New Balance 530',
        description: 'null',
        url: '../assets/image/new-balance-530-Lifestyle-Shoes.png',
        price: '3000000'),
    Product(
        id: '1003',
        name: 'Nike Air MAX alpha',
        description: 'null',
        url: '../assets/image/nike-Air-Max-Alpha-Trainer-5.png',
        price: '2300000'),
    Product(
        id: '1004',
        name: 'Nike COURT Vision',
        description: 'null',
        url: '../assets/image/nike-NIKE-COURT-VISION-LO.png',
        price: '54060000'),
    Product(
        id: '1005',
        name: 'Reboo Club C',
        description: 'null',
        url: '../assets/image/reebo-Club-C-85.png',
        price: '2000000'),
    Product(
        id: '1006',
        name: 'Reboo Royal',
        description: 'null',
        url: '../assets/image/reebok-Royal-Complete3Low.png',
        price: '7000000'),
  ];
  List<Product> get favoriteProducts =>
      productItems.where((product) => product.isFavorite).toList();
  //Syntax tersebut mengambil daftar produk yang sudah ada (productItems),
  //where() adalah metode untuk mengambil elemen dari daftar yang memenuhi suatu kondisi.
  //memilih hanya produk yang menjadi favorit (isFavorite),
  //dan mengembalikannya sebagai daftar produk favorit. Ini adalah cara singkat
  // dalam Dart untuk menghasilkan daftar yang difilter berdasarkan kriteria tertentu.
  //Kesimpulan: ambil semua produk dari daftar produk yang sudah ada,
  //lalu pilih hanya yang menjadi favorit, dan kembalikan mereka sebagai daftar produk favorit

  List<Product> get products => [...productItems];

  //Theme Controller
  bool isDark = false;
  void switchToLight(){
    isDark = !isDark;
    notifyListeners();
  }
  
  // Favorite Controller
  bool _showFavorite = false;
  bool get showFavorites => _showFavorite;
  void toggleShowFavorite() {
    _showFavorite = !_showFavorite;
    notifyListeners();
  }
  List<Product> get showProducts =>
      _showFavorite ? favoriteProducts : products;
  @override
  notifyListeners();
}
