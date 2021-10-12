import 'package:lojavirtual/models/user_manager.dart';
import 'package:lojavirtual/models/usuario.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual/helpers/validators.dart';

class LoginScreen extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text("Entrar"),
        centerTitle: true,
        actions: [
          FlatButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/signup');
              },
              child: Text(
                "Criar Conta",
                style: TextStyle(fontSize: 14, color: Colors.white),
              ))
        ],
      ),
      body: Center(
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: Consumer<UserManager>(
              builder: (_, userManager, __) {
                return ListView(
                  padding: EdgeInsets.all(16),
                  shrinkWrap: true,
                  children: [
                    TextFormField(
                      decoration: InputDecoration(hintText: "E-mail"),
                      controller: emailController,
                      enabled: !userManager.loading,
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      validator: (email) {
                        if (!emailValid(email!)) {
                          return "E-mail inválido";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      decoration: InputDecoration(hintText: "Senha"),
                      controller: passwordController,
                      enabled: !userManager.loading,
                      autocorrect: false,
                      obscureText: true,
                      validator: (pass) {
                        if (pass == null || pass.isEmpty || pass.length < 6) {
                          return 'Senha inválida';
                        } else {
                          return null;
                        }
                      },
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: FlatButton(
                        padding: EdgeInsets.zero,
                        child: Text("Esqueci minha senha"),
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      height: 44,
                      child: RaisedButton(
                        onPressed: userManager.loading
                            ? null
                            : () {
                                if (formKey.currentState!.validate()) {
                                  userManager.signIn(
                                      usuario: Usuario(
                                          email: emailController.text,
                                          password: passwordController.text),
                                      onFail: (e) {
                                        scaffoldKey.currentState!.showSnackBar(
                                            SnackBar(
                                                content: Text(e.toString())));
                                      },
                                      onSuccess: (e) {
                                        Navigator.of(context).pop();
                                      });
                                }
                              },
                        color: Theme.of(context).primaryColor,
                        disabledColor:
                            Theme.of(context).primaryColor.withAlpha(100),
                        textColor: Colors.white,
                        child: userManager.loading
                            ? CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.white),
                              )
                            : Text(
                                "Entrar",
                                style: TextStyle(fontSize: 18),
                              ),
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
