import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:lojavirtual/helpers/firebase_errors.dart';
import 'package:lojavirtual/models/usuario.dart';

class UserManager extends ChangeNotifier{

  UserManager()  {
    _loadCurrentUser();
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  Usuario? user;

  bool _loading = false;

  Future<void> signIn({required Usuario usuario, required Function onFail, required Function onSuccess}) async{
    loading = true;

    try {
      final UserCredential result = await auth
          .signInWithEmailAndPassword(
          email: usuario.email,
          password: usuario.password);

      await _loadCurrentUser(user:result.user!);

      onSuccess(result.user!.uid);
    } catch(e){
      onFail(getErrorString(e.toString()));
    }

    loading = false;

  }

  Future<void> signUp({required Usuario usuario, required Function onFail, required Function onSuccess})async {
    loading = true;

    try {
      UserCredential user = await auth.createUserWithEmailAndPassword(
          email: usuario.email, password: usuario.password);

      usuario.id = user.user!.uid;
      this.user = usuario;

      await usuario.saveData();
      onSuccess();

    }catch (e){
      onFail(e.toString());
    }

    loading = false;

  }

  bool get loading => _loading;

  set loading(bool value){
    _loading = value;
    notifyListeners();
  }

  bool get isLoggedIn => user != null;

  Future<void> _loadCurrentUser({User? user}) async {
    User currentUser = user ?? await auth!.currentUser!;

    if(currentUser != null){
      DocumentSnapshot docUser = await FirebaseFirestore.instance.collection("users").doc(currentUser.uid).get();
      this.user = Usuario.fromDocument(docUser);
      print(this.user!.name);
      notifyListeners();
    }
  }

  void signOut() {
    auth.signOut();
    user = null;
    notifyListeners();
  }

}