import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lojavirtual/models/cart_product.dart';
import 'package:lojavirtual/models/product.dart';
import 'package:lojavirtual/models/user_manager.dart';
import 'package:lojavirtual/models/usuario.dart';

class CartManager {

  List<CartProduct> items = [];

  Usuario? user;

  void addToCart(Product product){
    try{
      final e = items.firstWhere((p) => p.stackable(product));
      e.quantity = e.quantity! +1;
    }catch(e) {
      final cartProduct = CartProduct.fromProduct(product);
      items.add(cartProduct);
      user!.cartReference.add(cartProduct.toCartItemMap());
    }

  }

  void updateUser(UserManager userManager) {
    user = userManager.user;
    items.clear();
    if(user != null){
      _loadCartItems();
    }
  }

  Future<void> _loadCartItems() async {
    QuerySnapshot cartSnap = await user!.cartReference.get();
    items = cartSnap.docs.map((e) => CartProduct.fromDocument(e)).toList();
  }

}