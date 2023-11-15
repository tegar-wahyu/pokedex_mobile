# pokedex_mobile

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

# TUGAS 7
## Apa perbedaan utama antara stateless dan stateful widget dalam konteks pengembangan aplikasi Flutter?
1. **Stateless Widget**: Widget ini tidak dapat mengubah keadaannya. Artinya adalah setelah membuat widget, widget ini tidak dapat diubah. <br>
Contoh: `Material`, `InkWell`, `Container`, `Center`, `Column`, `Icon`, `Padding`, dan `Text`.

2. **Stateful Widget**: Widget ini dapat mengubah keadaannya. Artinya adalah kita dapat memperbarui data yang ditampilkan oleh widget atau mengubah penampilannya. <br>
Contoh: `ShopCard` bisa jadi contoh Stateful Widget jika `item` berubah sepanjang waktu.

## Sebutkan seluruh widget yang kamu gunakan untuk menyelesaikan tugas ini dan jelaskan fungsinya masing-masing.
- `MyHomePage (Stateless Widget)`: halaman utama atau beranda dari aplikasi. Child dari StatelessWidget, yang berarti tidak memiliki keadaan internal yang berubah.
- `MyApp (Stateless Widget)`: Ini adalah representasi dari aplikasi Flutter yang tidak memiliki state yang berubah sepanjang waktu karena merupakan turunan dari StatelessWidget.
- `Scaffold`: Ini adalah widget yang menyediakan struktur dasar visual untuk membangun halaman, termasuk AppBar dan body.
- `AppBar`: Ini adalah widget yang ditempatkan di bagian atas halaman yang menampilkan judul aplikasi.
- `title`: Ini adalah judul aplikasi yang ditampilkan di AppBar atau dalam daftar aplikasi.
- `SingleChildScrollView``: Widget ini membungkus konten utama dan memungkinkan pengguna untuk menggulir jika konten melebihi ukuran layar.
- `MaterialApp`: Widget ini mendefinisikan struktur dasar untuk membangun aplikasi Flutter.
- `GridView.count``: Widget ini digunakan untuk menampilkan item dalam bentuk grid dengan jumlah kolom yang ditentukan.
- `InkWell`: Widget yang merespons sentuhan dengan efek visual air.
- `Container`: Widget yang menjadi wadah widget umum seperti padding, margin, dan background color.
- `Center`: Widget yang memposisikan child di tengah.
- `Column`: Widget yang menampilkan children dalam urutan vertikal.
- `Icon`: Widget yang menampilkan ikon.
- `Padding`: Widget yang memberikan padding ke anaknya.
- `Text`: Widget yang menampilkan teks.
- `ColorScheme`: Ini adalah bagian dari tema yang digunakan untuk mengatur skema warna aplikasi, termasuk warna latar belakang dan teks.
- `theme`: Ini adalah tema aplikasi yang digunakan untuk mengkustomisasi tampilan aplikasi.
- `ShopItem`: Ini adalah class yang mendefinisikan item toko, termasuk atribut seperti nama, ikon, dan warna.
- `ShopCard (Stateless Widget)`: Widget ini digunakan untuk menampilkan setiap item toko dalam bentuk kartu dan memiliki handler ketika diklik yang menampilkan snackbar.
- `Container`: Widget ini digunakan untuk mengelompokkan dan memberikan layout pada ikon dan teks dalam kartu.

## Jelaskan bagaimana cara kamu mengimplementasikan checklist di atas secara step-by-step (bukan hanya sekadar mengikuti tutorial)

### Membuat sebuah program Flutter baru dengan tema inventory seperti tugas-tugas sebelumnya.
Menggunakan perintah `flutter create pokedex_mobile` di terminal.

### Membuat tombol sederhana dengan ikon dan teks untuk melihat daftar item (Lihat Item), menambah item (Tambah Item), dan logout (Logout)
Dalam file `menu.dart`, tombol-tombol tersebut dibuat sebagai bagian dari `GridView` dalam `MyHomePage` widget. Setiap tombol adalah instance dari `ShopCard` widget yang mewakili item dalam daftar `items`.

**Membuat 3 Tombol**: Daftar `items` dibuat dalam `MyHomePage` widget. Setiap item adalah instance dari `ShopItem` class yang memiliki nama, ikon, dan warna. 
```dart
class ShopItem {
  final String name;
  final IconData icon;
  final Color color;

  ShopItem(this.name, this.icon, this.color);
}
```
Nama item adalah teks yang akan ditampilkan pada tombol, ikon adalah ikon yang akan ditampilkan, dan warna adalah warna latar belakang tombol.
<br>
Kemudian dibuat list items yang berisi tombol-tombol.
```dart
final List<ShopItem> items = [
  ShopItem("Lihat Item", Icons.checklist, const Color.fromARGB(255, 255, 0, 0)),
  ShopItem("Tambah Item", Icons.add_shopping_cart, const Color.fromARGB(255, 255, 213, 0)),
  ShopItem("Logout", Icons.logout, const Color.fromARGB(255, 157, 255, 0)),
];
```

**Membuat GridView**: `GridView` dibuat dalam metode `build` dari `MyHomePage`. `GridView` berisi beberapa `ShopCard` yang dibuat dari daftar `items`.

```dart
...
GridView.count(
    primary: true,
    padding: const EdgeInsets.all(20),
    crossAxisSpacing: 10,
    mainAxisSpacing: 10,
    crossAxisCount: 3,
    shrinkWrap: true,
    children: items.map((ShopItem item) {
        return ShopCard(item);
    }).toList(),
),
...
```

### Memunculkan Snackbar dengan tulisan "Kamu telah menekan tombol {nama tombol}"
**Membuat ShopCard**: `ShopCard` adalah widget yang mewakili setiap item dalam daftar `items`. Di dalam metode `build`, sebuah `Material` dibuat dengan `InkWell`. `InkWell` adalah widget yang merespons sentuhan. Ketika `InkWell` diklik, sebuah `SnackBar` ditampilkan dengan pesan "Kamu telah menekan tombol {nama item}!". Di dalam `InkWell`, ada `Container` yang berisi `Icon` dan `Text` dari `ShopItem`.

```dart
class ShopCard extends StatelessWidget {
  final ShopItem item;

  const ShopCard(this.item, {super.key}); // Constructor

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
```

# TUGAS 8
## Jelaskan perbedaan antara Navigator.push() dan Navigator.pushReplacement(), disertai dengan contoh mengenai penggunaan kedua metode tersebut yang tepat!
`Navigator.push()` digunakan untuk menavigasi ke halaman baru dan menambahkannya ke tumpukan navigasi. Halaman sebelumnya tetap ada di tumpukan dan pengguna dapat kembali ke halaman tersebut dengan tombol kembali.<br>
`Navigator.pushReplacement()` digunakan untuk menavigasi ke halaman baru dan menggantikan halaman saat ini di tumpukan navigasi. Halaman sebelumnya dihapus dari tumpukan dan pengguna tidak dapat kembali ke halaman tersebut.

Contoh penggunaan:

```dart
// Menggunakan Navigator.push()
Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => SecondPage()),
);

// Menggunakan Navigator.pushReplacement()
Navigator.pushReplacement(
  context,
  MaterialPageRoute(builder: (context) => SecondPage()),
);
```
## Jelaskan masing-masing layout widget pada Flutter dan konteks penggunaannya masing-masing!
1. **Container**: Digunakan untuk mengelompokkan widget dan memberikan padding, margin, atau dekorasi. Misalnya untuk memberikan padding ke `Text` widget.

2. **Row dan Column**: Digunakan untuk menata widget secara horizontal (`Row`) dan vertikal (`Column`). Misalnya untuk menampilkan ikon dan teks secara berdampingan.

3. **Stack**: Digunakan untuk menumpuk beberapa widget di atas satu sama lain. Misalnya untuk menempatkan teks di atas gambar.

4. **GridView**: Digunakan untuk menampilkan item dalam bentuk grid. Misalnya untuk menampilkan galeri foto.

5. **ListView**: Digunakan untuk menampilkan item dalam bentuk list. Misalnya untuk menampilkan daftar pesan dalam aplikasi chat.

6. **Card**: Digunakan untuk menampilkan informasi dalam bentuk kartu. Misalnya untuk menampilkan informasi kontak.

7. **Scaffold**: Digunakan untuk membuat struktur dasar aplikasi, seperti app bar, body, dan floating action button. Misalnya untuk membuat halaman dengan app bar dan body.

8. **AppBar**: Digunakan untuk menampilkan bar di bagian atas halaman. Misalnya untuk menampilkan judul halaman dan action button.

## Sebutkan apa saja elemen input pada form yang kamu pakai pada tugas kali ini dan jelaskan mengapa kamu menggunakan elemen input tersebut!
Semua input yang diperlukan adalah berupa teks dalam bentuk string dan integer, maka digunakan `TextField` yang diwrap oleh `FormField` atau `FormField` yang berisi `TextField` yaitu `TextFormField`

## Bagaimana penerapan clean architecture pada aplikasi Flutter?
**1. Gambaran Clean Architecture:**<br>
Separation of Concerns:<br>
Clean Architecture mengikuti prinsip Separation of Concerns, membagi perangkat lunak menjadi lapisan.
Tujuannya adalah memiliki lapisan yang terorganisir dengan baik, memungkinkan penggunaan ulang, pengembangan independen, skalabilitas, keterbacaan, pengujian, dan pemeliharaan yang mudah.

**2. Lapisan-lapisan Clean Architecture di Flutter:**<br>
**Lapisan Fitur:**
- Lapisan Presentasi:
  - Berisi UI dan penangan acara.
  - Menggunakan pola manajemen status seperti BLoC, Provider, GetX.
  - Termasuk halaman, manajemen status, dan widget khusus yang diperlukan oleh halaman.

**Lapisan Domain:**
- Lapisan Logika Bisnis:
  - Berisi Entitas, Kasus Pengguna, dan Antarmuka Repositori.
  - Ditulis secara murni dalam Dart tanpa elemen Flutter.
  - Berfokus pada aturan bisnis aplikasi tertentu.

**Lapisan Data:**
- Lapisan Pengambilan Data:
  - Bertanggung jawab atas pengambilan data dari panggilan API dan basis data lokal.
  - Termasuk implementasi repositori, model DTO, sumber data (remote dan lokal), dan pemeta.

## Jelaskan bagaimana cara kamu mengimplementasikan checklist di atas secara step-by-step! (bukan hanya sekadar mengikuti tutorial)

### Membuat minimal satu halaman baru pada aplikasi, yaitu halaman formulir tambah item baru.
Membuat file `pokedex_form.dart` pada direktori 'lib/screens' yang berisi kode:
```dart
import 'package:flutter/material.dart';
import 'package:pokedex_mobile/models/pokedex_models.dart';
import 'package:pokedex_mobile/widgets/left_drawer.dart';
import 'package:flutter/services.dart';

List<Pokemon> pokeList = [];

class PokeFormPage extends StatefulWidget {
  const PokeFormPage({super.key});

  @override
  State<PokeFormPage> createState() => _PokeFormPageState();
}

class _PokeFormPageState extends State<PokeFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _name = "";
  int _amount = 0;
  String _description = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Form Tambah Pokemon',
          ),
        ),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Nama Pokemon",
                  labelText: "Nama Pokemon",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (String? value) {
                  setState(() {
                    _name = value!;
                  });
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Nama tidak boleh kosong!";
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Jumlah",
                  labelText: "Jumlah",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                onChanged: (String? value) {
                  setState(() {
                    _amount = int.parse(value!);
                  });
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Jumlah tidak boleh kosong!";
                  }
                  if (int.tryParse(value) == null) {
                    return "Jumlah harus berupa angka!";
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Deskripsi",
                  labelText: "Deskripsi",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (String? value) {
                  setState(() {
                    _description = value!;
                  });
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Deskripsi tidak boleh kosong!";
                  }
                  return null;
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.indigo),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Pokemon newPokemon =
                          Pokemon(_name, _amount, _description);
                      pokeList.add(newPokemon);
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Pokemon berhasil tersimpan'),
                            content: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Nama: $_name'),
                                  Text('Jumlah: $_amount'),
                                  Text('Deskripsi: $_description'),
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(
                                child: const Text('OK'),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                    _formKey.currentState!.reset();
                  },
                  child: const Text(
                    "Save",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
```

### Mengarahkan pengguna ke halaman form tambah item baru ketika menekan tombol `Tambah Item` pada halaman utama.
- Menambahkan kode berikut pada bagian `onTap()` milik class `PokeCard` dalam file `pokedex_card.dart`
```dart
          if (item.name == "Tambah Pokemon") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PokeFormPage(),
              ),
            );
          }
``` 

### Memunculkan data sesuai isi dari formulir yang diisi dalam sebuah `pop-up` setelah menekan tombol `Save` pada halaman formulir tambah item baru.
- Menambahkan kode berikut ke dalam file `pokedex_form.dart`
```dart
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Pokemon newPokemon =
                          Pokemon(_name, _amount, _description);
                      pokeList.add(newPokemon);
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Pokemon berhasil tersimpan'),
                            content: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Nama: $_name'),
                                  Text('Jumlah: $_amount'),
                                  Text('Deskripsi: $_description'),
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(
                                child: const Text('OK'),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                        },
                      );
                    _formKey.currentState!.reset();
                    }
                    else {
                      // Munculkan popup jika validasi gagal
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Gagal menyimpan pokemon'),
                            content: const Text(
                                'Pastikan semua field terisi dengan benar!'),
                            actions: [
                              TextButton(
                                child: const Text('OK'),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
```

### Membuat sebuah drawer pada aplikasi 
```dart
...
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Halaman Utama'),
            // Bagian redirection ke MyHomePage
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyHomePage(),
                  ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_shopping_cart),
            title: const Text('Tambah Pokemon'),
            // Bagian redirection ke ShopFormPage
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PokeFormPage(),
                  ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.checklist),
            title: const Text('Lihat Pokemon'),
            // Bagian redirection ke PokeListPage
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PokeListPage(pokeList: pokeList),
                  ));
            },
          ),
...
```

## BONUS
### Membuat sebuah halaman baru, yaitu halaman daftar item yang sudah dibuat dengan isi halamannya adalah setiap data produk yang sudah pernah dibuat.
Membuat file `pokedex_show` dalam direktori screens:
```dart
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
```

Tambahkan file `pokedex_models` dalam direktori models:
```dart
class Pokemon {
  final String name;
  final int amount;
  final String description;

  Pokemon(this.name, this.amount, this.description);
}
```
### Mengarahkan pengguna ke halaman tersebut jika menekan tombol Lihat Produk pada halaman utama atau drawer.
```dart
          ListTile(
            leading: const Icon(Icons.checklist),
            title: const Text('Lihat Pokemon'),
            // Bagian redirection ke PokeListPage
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PokeListPage(pokeList: pokeList),
                  ));
            },
          ),
```