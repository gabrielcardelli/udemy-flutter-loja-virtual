import 'package:flutter/material.dart';
import 'package:lojavirtual/models/user_manager.dart';
import 'package:provider/provider.dart';

class CustomDrawerHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(32, 24, 16, 8),
      height: 180,
      child: Consumer<UserManager>(
          builder: (_, userManager, __) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Loja do\nDaniel",
                  style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Olá, ${userManager.user?.name ?? ''}',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                GestureDetector(
                  onTap: () {
                    if (userManager.isLoggedIn) {
                      userManager.signOut();
                    } else {
                      Navigator.of(context).pushNamed("/login");
                    }
                  },
                  child: Text(
                    userManager.isLoggedIn ? 'Sair' : 'Entre ou cadastre-se >',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            );
        }),
    );
  }
}
