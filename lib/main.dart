import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lojavirtual/models/product_manager.dart';
import 'package:lojavirtual/models/user_manager.dart';
import 'package:lojavirtual/screens/base/base_screen.dart';
import 'package:lojavirtual/screens/login/login_screen.dart';
import 'package:lojavirtual/screens/signup/signup_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseApp app = await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => ProductManager(),
          lazy: false,
        )
      ],
      child: MaterialApp(
          title: 'Loja do Daniel',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              primaryColor: const Color.fromARGB(255, 4, 125, 141),
              appBarTheme: AppBarTheme(
                  color: const Color.fromARGB(255, 4, 125, 141), elevation: 0),
              scaffoldBackgroundColor: Color.fromARGB(255, 4, 125, 141)),
          initialRoute: '/base',
          routes: {
            '/signup': (context) => SignUpScreen(),
            '/login': (context) => LoginScreen(),
            '/base': (context) => BaseScreen()
          }),
    );
  }
}
