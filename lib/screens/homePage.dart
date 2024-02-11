import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_app_1/models/productModel.dart';
import 'package:provider_app_1/providers/cartProvider.dart';
import 'package:provider_app_1/providers/productProvider.dart';
import 'package:provider_app_1/screens/cartPage.dart';
import 'package:provider_app_1/screens/detailsPage.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer<ProductsProvider>(
          builder: (context, productProv, child) {
            return Text((!productProv.showFavorites)
                ? 'HomePage'
                : 'HomePage - Favorite');
          },
        ),
        actions: [
          IconButton(
            icon: Consumer<ProductsProvider>(
              builder: (context, productProv, child) {
                return Icon(
                    (!productProv.isDark) ? Icons.dark_mode : Icons.light_mode);
              },
            ),
            onPressed: () {
              Provider.of<ProductsProvider>(context, listen: false)
                  .switchToLight();
              //Parameter listen: false digunakan dalam pemanggilan Provider.of<T>(context) atau Consumer<T> untuk
              //menonaktifkan fungsi mendengarkan perubahan data. Dengan kata lain, ketika Anda menggunakan listen: false,
              // widget tidak akan di-rebuild ketika ada perubahan pada data yang diberikan.
              // Hal ini berguna dalam beberapa situasi, misalnya ketika Anda hanya ingin mengakses nilai data awal
              //saat widget dibangun dan tidak tertarik untuk memperbarui widget ketika data berubah. Ini membantu mengoptimalkan
              //kinerja aplikasi dengan menghindari pembaruan widget yang tidak perlu.
            },
          ),
          SizedBox(width: 5),
          PopupMenuButton(
            onSelected: (value) {
              final productProv =
                  Provider.of<ProductsProvider>(context, listen: false);
              if (value == 0)
                productProv
                    .toggleShowFavorite(); // Ubah status tampilkan produk favorit
              if (value == 1)
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const CartProducts())); // Buka halaman tambah
            },
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  child: Consumer<ProductsProvider>(
                    builder: (context, productProv, child) {
                      return SizedBox(
                        child: Text((productProv.showFavorites)
                            ? "Hide Favorites"
                            : "Show Favorites"),
                      );
                    },
                  ),
                  value: 0,
                ),
                PopupMenuItem(
                  child: SizedBox(
                    child: Text('Cart'),
                  ),
                  value: 1,
                ),
              ];
            },
          )
        ],
      ),
      body: Consumer<ProductsProvider>(
        builder: (context, productProv, child) {
          return GridView.builder(
            padding: EdgeInsets.all(20),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 0.8 / 1.4,
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            itemCount: productProv.showProducts.length, // Ubah itemCount
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              var item =
                  productProv.showProducts[index]; // Gunakan showProducts
              return ChangeNotifierProvider<Product>.value(
                value: item,
                builder: (context, child) {
                  return Consumer<Product>(
                    builder: (context, product, child) {
                      return GridIProductItems(
                        id: product.id,
                        item: product,
                        name: product.name,
                        url: product.url,
                        price: product.price,
                        favorite: product.toggleIconFavorite,
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

class GridIProductItems extends StatelessWidget {
  const GridIProductItems({
    Key? key,
    required this.id,
    required this.item,
    required this.name,
    required this.url,
    required this.price,
    required this.favorite,
  });

  final Product item;
  final String id, name, url, price;
  final VoidCallback favorite;

  @override
  Widget build(BuildContext context) {
    final productProv = Provider.of<ProductsProvider>(context);
    final cartProv = Provider.of<CartProvider>(context);
    return Card(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          DetailsPage(title: item.id),
                    ),
                  );
                },
                child: Hero(
                  tag: item.id,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                DetailsPage(title: item.id),
                          ),
                        );
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(url),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(6.0),
                          ),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              right: 20.0,
                              top: 8.0,
                              child: IconButton(
                                onPressed: favorite,
                                icon: Icon(
                                  item.isFavorite
                                      ? Icons.favorite
                                      : Icons.favorite_border_outlined,
                                  color: item.isFavorite
                                      ? Colors.red
                                      : Colors.grey,
                                  size: 25,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 8.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    item.description,
                    style: TextStyle(fontSize: 12.0),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    "Rp ${price}",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 170, 46, 37),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 30, right: 5),
                    width: double.infinity,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () {
                          cartProv.addProductToCart(
                              idProduct: item.id,
                              nameProduct: item.name,
                              priceProduct: item.price,
                              urlProduct: item.url
                              );
                              print(cartProv.cartProducts);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Add to Cart',
                            style: TextStyle(
                              color: (productProv.isDark)
                                  ? Colors.white
                                  : Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
