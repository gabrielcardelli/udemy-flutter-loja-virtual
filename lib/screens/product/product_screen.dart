import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual/models/cart_manager.dart';
import 'package:lojavirtual/models/product.dart';
import 'package:lojavirtual/models/user_manager.dart';
import 'package:provider/provider.dart';

import 'components/size_widget.dart';

class ProductScreen extends StatelessWidget {
  ProductScreen(this.product);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: product,
      child: Scaffold(
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
                      product.name.toString(),
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
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
                    Padding(
                      padding: const EdgeInsets.only(top: 16, bottom: 8),
                      child: Text(
                        'Descrição',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Text(
                      product.description.toString(),
                      style: TextStyle(fontSize: 16),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16, bottom: 8),
                      child: Text(
                        'Tamanhos',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: product.sizes
                            .map((e) => SizeWidget(size: e))
                            .toList()),
                    SizedBox(
                      height: 20,
                    ),
                    if (product.hasStock)
                      Consumer2<UserManager, Product>(
                          builder: (_, userManager, product, __) {
                        return SizedBox(
                            height: 44,
                            width: MediaQuery.of(context).size.width,
                            child: RaisedButton(
                              onPressed: product.selectedSize != null
                                  ? () {
                                      if (userManager.isLoggedIn) {
                                        context.read<CartManager>().addToCart(product);
                                        Navigator.of(context)
                                            .pushNamed('/cart');
                                      } else {
                                        Navigator.of(context)
                                            .pushNamed('/login');
                                      }
                                    }
                                  : null,
                              textColor: Colors.white,
                              color: Theme.of(context).primaryColor,
                              child: Text(
                                userManager.isLoggedIn
                                    ? 'Adicionar ao Carrinho'
                                    : 'Entre para Comprar',
                                style: TextStyle(fontSize: 18),
                              ),
                            ));
                      })
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
