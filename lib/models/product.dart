import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'item_size.dart';

class Product extends ChangeNotifier{

  Product.fromDocument(DocumentSnapshot document){
    id = document.id;
    name = document.get("name");
    description = document.get("description");
    images = List<String>.from(document.get("images") as List<dynamic>);
    sizes = (document.get('sizes') as List<dynamic> ?? []).map((s) => ItemSize.fromMap(s)).toList();
    print(sizes);
  }

  late String id;

  late String name;

  late String description;

  late List<String> images;

  late List<ItemSize> sizes;

  ItemSize? _selectedSize;

  ItemSize? get selectedSize => _selectedSize;
  set selectedSize(ItemSize? value){
    _selectedSize = value;
    notifyListeners();
  }

  int get totalStock {
    int stock = 0;
    for(final size in sizes){
      stock += size.stock;
    }
    return stock;
  }

  bool get hasStock {
    return totalStock > 0;
  }

  ItemSize? findSize(String? name) {
    try {
      return sizes.firstWhere((size) => size.name == name);
    }catch(e){
      return null;
    }
  }

}