import 'package:cloud_firestore/cloud_firestore.dart';

class Product {

  Product.fromDocument(DocumentSnapshot document){
    id = document.id;
    name = document.get("name");
    description = document.get("description");
    images = List<String>.from(document.get("images") as List<dynamic>);
  }

  late String id;

  late String name;

  late String description;

  late List<String> images;

}