import 'package:flutter/material.dart';
import 'package:pokedex_mobile/screens/pokedex_form.dart';
import 'package:pokedex_mobile/screens/pokedex_show.dart';

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
    return Material(
      color: item.color,
      child: InkWell(
        // Area responsive terhadap sentuhan
        onTap: () {
          // Memunculkan SnackBar ketika diklik
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
                content: Text("Kamu telah menekan tombol ${item.name}!")));
          if (item.name == "Lihat Pokemon") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PokeListPage(pokeList: pokeList),
              ),
            );
          }

          if (item.name == "Tambah Pokemon") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PokeFormPage(),
              ),
            );
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
