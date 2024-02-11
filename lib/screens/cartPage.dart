import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_app_1/providers/cartProvider.dart';

class CartProducts extends StatelessWidget {
  const CartProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartProv = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back),
        ),
        title: Text('Cart'),
      ),
      body: (cartProv.cartProducts.values.isEmpty)
          ? Container(child: Center(child: Text("Your cart is empty!")))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartProv.cartProducts.length,
                    itemBuilder: (BuildContext context, int index) {
                      final product =
                          cartProv.cartProducts.values.toList()[index];
                      return SizedBox(
                        height: 180,
                        child: Card(
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              children: <Widget>[
                                Image.asset(
                                  product.image,
                                  width: 100,
                                  height: 100,
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Text(
                                        product.name,
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Text(
                                        'Rp ${double.parse(product.price).toStringAsFixed(0)}', // Konversi harga ke double
                                        style: TextStyle(
                                          color: const Color.fromARGB(
                                              255, 183, 48, 38),
                                        ),
                                      ),
                                      Text('Total: ${product.quantity}'),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          IconButton(
                                            onPressed: () => cartProv.decrement(
                                                idProduct:
                                                    product.id.toString()),
                                            icon: Icon(Icons.remove, size: 20),
                                          ),
                                          IconButton(
                                            onPressed: () => cartProv.increment(
                                                idProduct:
                                                    product.id.toString()),
                                            icon: Icon(Icons.add, size: 20),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  onPressed: () => cartProv.removeProductToCart(
                                      idProduct: product.id.toString()),
                                  tooltip: 'Remove',
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 100,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Total : Rp ${cartProv.totalPay.toStringAsFixed(0)}', // Konversi totalPay ke double
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          cartProv.clearElementInMap();
                          showDialog(
                             context: context,
                             builder: (BuildContext context) => AlertDialog(
                              title: Text('Thankss'),
                              content: Text("Done, Your list to clear"),
                            ),
                          );
                        },
                        child: Text(
                          'Submit',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
