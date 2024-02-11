import 'package:flutter/material.dart';
import 'package:provider_app_1/models/cartModels.dart';

class CartProvider with ChangeNotifier {
  Map<String, CartProduct> listCartProduct = {};
  Map<String, CartProduct> get cartProducts => {...listCartProduct};
  double get totalPay {
    double total = 0.0;
    listCartProduct.values.forEach((product) {
      total += int.parse(product.price) * product.quantity;
    });
    return total;
  }

  void addProductToCart(
      {required String idProduct, nameProduct, priceProduct, urlProduct}) {
    if (listCartProduct.containsKey(idProduct)) {
      listCartProduct.update(
          idProduct,
          (value) => CartProduct(
              id: value.id,
              name: value.name,
              image: value.image,
              price: value.price,
              quantity: value.quantity + 1));
      notifyListeners();
    } else {
      listCartProduct[idProduct] = CartProduct(
          id: int.parse(idProduct),
          name: nameProduct,
          image: urlProduct,
          price: priceProduct,
          quantity: 1);
      notifyListeners();
    }
  }

  void removeProductToCart({required String idProduct}) {
    listCartProduct.remove(idProduct);
    notifyListeners();
  }

  void increment({required String idProduct}) {
    if (listCartProduct.containsKey(idProduct)) {
      // Dapatkan produk dengan ID yang diberikan
      final product = listCartProduct[idProduct];
      if (product!.quantity >= 0)
        // Perbarui jumlah produk dengan menambahkan satu
        listCartProduct.update(
            idProduct,
            (value) => CartProduct(
                  id: value.id,
                  name: value.name,
                  image: value.image,
                  price: value.price,
                  quantity: value.quantity + 1, // Tambah satu ke jumlah produk
                ));

      // Panggil notifyListeners() agar listener dapat mendengar perubahan
      notifyListeners();
    }
  }

  void decrement({required String idProduct}) {
    if (listCartProduct.containsKey(idProduct)) {
      // Dapatkan produk dengan ID yang diberikan
      final product = listCartProduct[idProduct]!;
      if (product.quantity > 1) {
        // Jika jumlah produk lebih dari 1, kurangi satu dari jumlah produk
        listCartProduct.update(
          idProduct,
          (value) => CartProduct(
            id: value.id,
            name: value.name,
            image: value.image,
            price: value.price,
            quantity: value.quantity - 1,
          ),
        );
      } else {
        // Jika jumlah produk hanya 1, hapus produk dari keranjang
        removeProductToCart(idProduct: idProduct);
      }
      // Panggil notifyListeners() agar listener dapat mendengar perubahan
      notifyListeners();
    }
  }
  void clearElementInMap(){
    listCartProduct.clear();
    notifyListeners();
  }
}
