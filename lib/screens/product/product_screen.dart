import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual/models/product.dart';

class ProductScreen extends StatelessWidget {
  ProductScreen(this.product);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text(product.name)),
      body: ListView(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Carousel(
              images: product.images.map((e) => NetworkImage(e)).toList(),
              dotSize: 4,
              dotBgColor: Colors.transparent,
              dotColor: Theme.of(context).primaryColor,
              autoplay: false,
              dotSpacing: 15,
            ),
          ),
          Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 1),
                    child: Text(
                      'A partir de',
                      style: TextStyle(color: Colors.grey[600], fontSize: 13),
                    ),
                  ),
                  Text(
                    'R\$ 19.99',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor),
                  ),
                  Text(
                    'Descrição',
                    style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),
                  ),
                  Text(
                    product.description,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
