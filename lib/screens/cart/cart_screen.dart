import 'package:flutter/material.dart';
import 'package:lojavirtual/models/cart_manager.dart';
import 'package:provider/provider.dart';

import 'components/cart_tile.dart';
class CartScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Carrinho"),
        centerTitle: true,
      ),
      body: Consumer<CartManager>(
        builder: (_,cartManager,__){
          return Column(
            children:
              cartManager.items.map((cartProduct) => CartTile(cartProduct)).toList(),
          );
        },
      ),
    );
  }
}
