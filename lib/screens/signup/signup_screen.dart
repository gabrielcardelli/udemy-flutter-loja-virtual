import 'package:flutter/material.dart';
import 'package:lojavirtual/helpers/validators.dart';
import 'package:lojavirtual/models/user_manager.dart';
import 'package:lojavirtual/models/usuario.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final Usuario user = Usuario();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text("Criar Conta"),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: Consumer<UserManager>(
              builder: (_, userManager, __) {
                return ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.all(16),
                  children: [
                    TextFormField(
                      decoration: InputDecoration(hintText: 'Nome Completo'),
                      onSaved: (nome) => user.name = nome!,
                      enabled: !userManager.loading,
                      validator: (name) {
                        if (name!.isEmpty)
                          return 'Campo obrigatório';
                        else if (name.trim().split(" ").length <= 1) {
                          return 'Preencha seu nome completo';
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      enabled: !userManager.loading,
                      decoration: InputDecoration(hintText: 'Email'),
                      keyboardType: TextInputType.emailAddress,
                      onSaved: (email) => user.email = email!,
                      validator: (email) {
                        if (email!.isEmpty)
                          return 'Campo obrigatório';
                        else if (!emailValid(email)) {
                          return 'Email inválido';
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      enabled: !userManager.loading,
                      obscureText: true,
                      decoration: InputDecoration(hintText: 'Senha'),
                      onSaved: (password) => user.password = password!,
                      validator: (pass) {
                        if (pass!.isEmpty)
                          return 'Campo obrigatório';
                        else if (pass.length < 6) {
                          return 'Senha muito curta.';
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                        enabled: !userManager.loading,
                        obscureText: true,
                        decoration: InputDecoration(hintText: 'Repita a Senha'),
                        onSaved: (password) => user.confirmPassword = password!,
                        validator: (pass) {
                          if (pass!.isEmpty)
                            return 'Campo obrigatório';
                          else if (pass.length < 6) {
                            return 'Senha muito curta.';
                          } else {
                            return null;
                          }
                        }),
                    SizedBox(height: 16),
                    SizedBox(
                      height: 44,
                      child: RaisedButton(
                        onPressed: userManager.loading
                            ? null
                            : () {
                                if (formKey.currentState!.validate()) {
                                  formKey.currentState!.save();

                                  if (user.password != user.confirmPassword) {
                                    scaffoldKey.currentState!.showSnackBar(
                                        SnackBar(
                                            content:
                                                Text("Senhas não conferem!")));
                                  }
                                }

                                context.read<UserManager>().signUp(
                                    usuario: user,
                                    onFail: (e) {
                                      scaffoldKey.currentState!.showSnackBar(
                                          SnackBar(
                                              content: Text(
                                                  "Falha ao cadastrar: $e")));
                                    },
                                    onSuccess: () {
                                      Navigator.of(context).pop();
                                      debugPrint("sucesso");
                                    });
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
                                "Criar Conta",
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
