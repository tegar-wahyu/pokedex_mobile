import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:pokedex_mobile/screens/login.dart';
import 'package:pokedex_mobile/screens/pokedex_form.dart';
import 'package:pokedex_mobile/screens/pokedex_show.dart';
import 'package:provider/provider.dart';

class PokeItem {
  final String name;
  final IconData icon;
  final Color color;

  PokeItem(this.name, this.icon, this.color);
}

class PokeCard extends StatelessWidget {
  final PokeItem item;

  const PokeCard(this.item, {super.key}); // Constructor

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Material(
      color: item.color,
      child: InkWell(
        // Area responsive terhadap sentuhan
        onTap: () async {
          // Memunculkan SnackBar ketika diklik
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
                content: Text("Kamu telah menekan tombol ${item.name}!")));

          if (item.name == "Tambah Pokemon") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PokeFormPage(),
              ),
            );
          }
          else if (item.name == "Lihat Pokemon") {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const PokeListPage()));
          }
          else if (item.name == "Logout") {
            final response = await request.logout(
                "http://tegar-wahyu-tugas.pbp.cs.ui.ac.id/auth/logout/");
            // final response = await request.logout(
            //     "http://127.001:8000/auth/logout/");
            String message = response["message"];
            if (response['status']) {
              String uname = response["username"];
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("$message Sampai jumpa, $uname."),
              ));
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(message),
              ));
            }
          }
        },
        child: Container(
          // Container untuk menyimpan Icon dan Text
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item.icon,
                  color: Colors.white,
                  size: 30.0,
                ),
                const Padding(padding: EdgeInsets.all(3)),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
