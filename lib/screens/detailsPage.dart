import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text("Details Product"),
      ),
      body: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 300,
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10), // Membuat sudut kotak sedikit melengkung
              image: DecorationImage(
                image: AssetImage('assets/image/adidas-tobacco-gruen-shoes.png'), // Path gambar yang diperbaiki
                fit: BoxFit.contain,
              ),
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              // Tambahkan aksi yang dijalankan saat tombol ditekan
            },
            child: Text('Add to Cart'),
          ),
        ],
      ),
    );
  }
}
