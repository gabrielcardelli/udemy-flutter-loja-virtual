import 'package:flutter/material.dart';
import 'package:lojavirtual/common/custom_icom_button.dart';
import 'package:lojavirtual/models/cart_product.dart';

class CartTile extends StatelessWidget {
  CartTile(this.cartProduct);

  final CartProduct cartProduct;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            SizedBox(
              height: 80,
              width: 80,
              child: Image.network(cartProduct.product!.images.first),
            ),
            Expanded(
                child: Padding(
              padding: EdgeInsets.only(left: 16),
              child: Column(
                children: [
                  Text(
                    cartProduct.product!.name,
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      "Tamanho: ${cartProduct.size}",
                      style: TextStyle(fontWeight: FontWeight.w300),
                    ),
                  ),
                  Text(
                    'R\$ ${cartProduct.unitPrice!.toStringAsFixed(2)}',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            )),
            Column(
              children: [
                CustomIconButton(
                    iconData: Icons.add,
                    color: Theme.of(context).primaryColor,
                    onTap: cartProduct.increment),
                Text(
                  '${cartProduct.quantity}',
                  style: TextStyle(fontSize: 20),
                ),
                CustomIconButton(
                    iconData: Icons.remove,
                    color: Theme.of(context).primaryColor,
                    onTap: cartProduct.decrement),
              ],
            )
          ],
        ),
      ),
    );
  }
}
