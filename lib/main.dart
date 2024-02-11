import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_app_1/providers/cartProvider.dart';
import 'package:provider_app_1/providers/productProvider.dart';
import 'package:provider_app_1/screens/homePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();
  
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProductsProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartProvider()
        )
      ],
      child: Consumer<ProductsProvider>(
        builder: (context, productProv, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: productProv.isDark ? ThemeData.dark() : ThemeData(),
            home: HomePage()
          );
        },
      ),
    );
  }
}
