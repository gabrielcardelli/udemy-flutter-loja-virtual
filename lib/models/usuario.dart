import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Usuario {

  Usuario({this.name = "",  this.email = "", this.password = "", this.confirmPassword = ""});

  Usuario.fromDocument(DocumentSnapshot doc){
    name = doc.get('name') ;
    email = doc.get('email');
    id = doc.id;
  }

  late String id;
  late String email;
  late String password;
  late String confirmPassword;
  late String name;

  DocumentReference get firestoreRef =>
      FirebaseFirestore.instance.collection("users").doc(id);

  CollectionReference get cartReference => firestoreRef.collection('cart');

  Future<void> saveData() async {
    await firestoreRef.set(toMap());

  }

  Map<String,dynamic> toMap(){
    return {
      'name': name,
     'email':email
    };
  }

}