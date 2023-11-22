import 'package:flutter/material.dart';
import 'package:pokedex_mobile/models/pokedex_models.dart';

class DetailPokemonPage extends StatelessWidget {
  final Item item;

  DetailPokemonPage({required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            '${item.fields.name}',
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.indigo[900],
          foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              item.fields.name,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 10),
            Text("Nama: ${item.fields.name}"),
            const SizedBox(height: 10),
            Text("Jumlah : ${item.fields.amount}"),
            const SizedBox(height: 10),
            Text("Deskripsi : ${item.fields.description}"),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}