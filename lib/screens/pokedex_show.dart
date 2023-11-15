import 'package:flutter/material.dart';
import 'package:pokedex_mobile/models/pokedex_models.dart';
import 'package:pokedex_mobile/widgets/left_drawer.dart';

class PokeListPage extends StatelessWidget {
  final List<Pokemon> pokeList;

  const PokeListPage({Key? key, required this.pokeList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Pokemon List',
          ),
        ),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: ListView.builder(
        itemCount: pokeList.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 5,
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: ListTile(
              title: Text(pokeList[index].name),
              subtitle: Text(
                  'Jumlah: ${pokeList[index].amount} | Deskripsi: ${pokeList[index].description}'),
              onTap: () {
                // Menampilkan pop up informasi pokemon
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(pokeList[index].name),
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Jumlah: ${pokeList[index].amount}'),
                          Text('Deskripsi: ${pokeList[index].description}'),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Tutup'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
