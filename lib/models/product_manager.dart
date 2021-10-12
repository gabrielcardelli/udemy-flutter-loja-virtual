import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:lojavirtual/models/product.dart';

class ProductManager extends ChangeNotifier {

  ProductManager(){
    _loadAllProducts();
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<Product> allProducts = [];

  Future<void> _loadAllProducts() async {
    final QuerySnapshot snapProducts = await firestore.collection('products').get();
    allProducts = snapProducts.docs.map((e) => Product.fromDocument(e)).toList();
    notifyListeners();
  }

}