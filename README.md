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

# TUGAS 9

## Apakah bisa kita melakukan pengambilan data JSON tanpa membuat model terlebih dahulu? Jika iya, apakah hal tersebut lebih baik daripada membuat model sebelum melakukan pengambilan data JSON?

Ya, kita bisa melakukan pengambilan data JSON tanpa membuat model terlebih dahulu di Flutter. Kita bisa menggunakan `dart:convert` untuk mengubah JSON menjadi Map.

Contoh:

```dart
import 'dart:convert';

void main() {
  String jsonString = '{"name":"John", "age":30, "city":"New York"}';
  Map<String, dynamic> user = jsonDecode(jsonString);
  print('Name: ${user['name']}, Age: ${user['age']}, City: ${user['city']}');
}
```

Namun, pendekatan ini biasanya tidak disarankan untuk aplikasi yang lebih besar atau kompleks. Membuat model memberikan beberapa keuntungan, seperti:

1. **Type Safety**: Dengan model, kita mendapatkan keamanan tipe, yang berarti kita dapat mencegah kesalahan tipe data.

2. **Readability**: Kode menjadi lebih mudah dibaca dan dipahami.

3. **Maintainability**: Jika struktur data berubah, kita hanya perlu mengubah model, dan kesalahan akan ditunjukkan di tempat-tempat lain di kode yang perlu diperbarui.

## Jelaskan fungsi dari CookieRequest dan jelaskan mengapa instance CookieRequest perlu untuk dibagikan ke semua komponen di aplikasi Flutter.

CookieRequest adalah kelas yang berfungsi sebagai bagian integral dari implementasi manajemen otentikasi menggunakan cookies dalam aplikasi Flutter. Fungsionalitas utama dari kelas ini mencakup inisialisasi dan pemeliharaan cookies, permintaan HTTP dengan otentikasi, manajemen sesi pengguna, penanganan cookies, serta keamanan dan pengaturan cookies.
<br>

Pertama-tama, kelas ini memiliki fungsi init() yang bertugas menginisialisasi dan memelihara status cookies, termasuk membaca cookies yang sudah tersimpan, memeriksa status login pengguna, dan mengelola headers yang berisi informasi cookie. Dalam melakukan permintaan HTTP, kelas ini menyertakan informasi otentikasi dalam header jika pengguna sudah login. Selain itu, CookieRequest juga menangani login dan logout, serta mengelola cookies, termasuk pembacaan dari penyimpanan lokal, pembaruan berdasarkan respons HTTP, dan pembuatan header cookie dengan fungsi-fungsi khusus.
<br>

Mengapa perlu membagikan instance CookieRequest ke semua komponen di aplikasi Flutter? Hal ini penting karena:
<br>

Pemeliharaan Status Login: Dengan membagikan instance CookieRequest ke semua komponen, status login pengguna dapat diakses dan diperbarui secara konsisten di seluruh aplikasi. Ini memastikan respons yang konsisten terhadap perubahan status login di berbagai komponen.
<br>

Pengelolaan Otentikasi: Instance CookieRequest menyimpan informasi otentikasi dan cookies. Dengan membagikannya ke berbagai komponen, informasi otentikasi dapat diakses dari mana saja dalam aplikasi, memfasilitasi komunikasi efektif dengan server dan pemeliharaan otentikasi tanpa perlu mengulang proses autentikasi.
<br>

Pemrosesan Permintaan HTTP: Dengan menyediakan instance CookieRequest ke berbagai komponen, setiap komponen dapat melakukan permintaan HTTP dengan otentikasi tanpa perlu mengulang proses autentikasi. Ini meningkatkan efisiensi dan mengurangi redundansi kode, karena otentikasi hanya perlu dilakukan sekali dan dapat digunakan oleh seluruh aplikasi.
<br>

Manajemen Cookies yang Konsisten: Melalui instance CookieRequest, komponen-komponen dapat mengakses dan memanipulasi cookies secara konsisten. Ini membantu dalam penanganan cookies dan menjaga konsistensi antara komponen-komponen yang berbeda, mencegah terjadinya konflik atau ketidaksesuaian antara informasi cookies yang disimpan di berbagai bagian aplikasi.

## Jelaskan mekanisme pengambilan data dari JSON hingga dapat ditampilkan pada Flutter.
Data diambil melalui respons dari URL yang telah ditentukan dalam proyek Django. Respons tersebut kemudian didekripsi menjadi format JSON dan selanjutnya dibentuk menjadi sebuah daftar item yang berisi elemen-elemen Item. Setiap elemen dalam daftar ini berasal dari hasil dekripsi JSON melalui proses iterasi, di mana masing-masing item ditambahkan ke dalam daftar item.
<br>

Untuk mendapatkan hasil dari pengambilan item, digunakan `FutureBuilder`. FutureBuilder memberikan kemampuan untuk mengakses hasil dari fungsi asinkron (async) yang bertanggung jawab atas pengambilan item. Hasil dari proses ini selanjutnya ditampilkan menggunakan ListView.builder, yang memungkinkan pembuatan tampilan dinamis berdasarkan data yang diterima.

## Jelaskan mekanisme autentikasi dari input data akun pada Flutter ke Django hingga selesainya proses autentikasi oleh Django dan tampilnya menu pada Flutter.
Pertama, pengguna memasukkan username dan password melalui TextField dalam kerangka kerja Flutter, dan data ini disimpan dalam variabel username dan password. Ketika tombol login ditekan, aplikasi mengirimkan permintaan HTTP POST ke endpoint /auth/login/ di server Django. Informasi username dan password dikirimkan sebagai bagian dari body permintaan dalam format JSON.
<br>

Server Django menerima permintaan dan melakukan autentikasi terhadap pengguna. Jika autentikasi berhasil, Django mengirimkan respons yang berisi pesan sukses dan informasi pengguna. Namun, jika autentikasi gagal, Django mengirimkan respons dengan pesan kesalahan. Aplikasi Flutter menerima respons dari Django dan memeriksa apakah autentikasi berhasil. Jika berhasil, aplikasi akan memandu pengguna ke halaman utama (MyHomePage); sebaliknya, jika gagal, aplikasi akan menampilkan pesan kesalahan.
<br>

Setelah berhasil login, pengguna diarahkan ke halaman utama aplikasi di mana menu aplikasi ditampilkan.
## Sebutkan seluruh widget yang kamu pakai pada tugas ini dan jelaskan fungsinya masing-masing.
`AppBar`: AppBar menampilkan widget toolbar, leading, title, dan actions di atas bagian bawah.
<br>
`Column`: Sebuah widget yang menampilkan Children secara vertikal.
<br>
`Scaffold`: Scaffold adalah sebuah kelas di Flutter yang menyediakan banyak widget atau API seperti Drawer, Snack-Bar, Bottom-Navigation-Bar, Floating-Action-Button, App-Bar, dll. Scaffold akan memperluas atau mengisi seluruh layar perangkat. Ia akan mengisi ruang yang tersedia. Scaffold akan menyediakan kerangka untuk mengimplementasikan tata letak desain material dasar dari aplikasi.
<br>
`Container`: Sebuah widget yang membungkus dan menggabungkan widget painting, positioning, dan sizing umum.
<br>
`TextField`: Sebuah text field memungkinkan pengguna memasukkan teks, baik dengan keyboard fisik atau dengan keyboard di layar.
<br>
`ElevatedButton`: Sebuah tombol terangkat adalah label child yang ditampilkan pada widget Material yang Material.elevation-nya meningkat ketika tombol ditekan.
<br>
`FutureBuilder`: Sebuah widget yang membangun dirinya sendiri berdasarkan snapshot terbaru dari interaksi dengan Future.
<br>
`SnackBar`: SnackBar adalah widget Flutter yang memungkinkan untuk sementara menampilkan pesan pop-up di aplikasi.
<br>
`Navigator`: Sebuah widget yang mengelola set children dengan stack discipline.
<br>
`ListView.builder`: Konstruktor ListView.builder mengambil IndexedWidgetBuilder, yang membangun children.

## Jelaskan bagaimana cara kamu mengimplementasikan checklist di atas secara step-by-step! (bukan hanya sekadar mengikuti tutorial).
### Memastikan deployment proyek tugas Django kamu telah berjalan dengan baik.

### Membuat halaman login pada proyek tugas Flutter.
1. Install package:
	```bash
	flutter pub add provider
	flutter pub add pbp_django_auth
	```
2. Membuat file `login.dart` pada direktory `lib/screens` yang berisi:
```dart 
import 'package:pokedex_mobile/screens/menu.dart';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const LoginApp());
}

class LoginApp extends StatelessWidget {
  const LoginApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
              ),
            ),
            const SizedBox(height: 12.0),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            const SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () async {
                String username = _usernameController.text;
                String password = _passwordController.text;

                // Cek kredensial
                final response =
                    await request.login("http://tegar-wahyu-tugas.pbp.cs.ui.ac.id/create-flutter/",{
                  'username': username,
                  'password': password,
                });

                if (request.loggedIn) {
                  String message = response['message'];
                  String uname = response['username'];
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => MyHomePage()),
                  );
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(SnackBar(
                        content: Text("$message Selamat datang, $uname.")));
                } else {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Login Gagal'),
                      content: Text(response['message']),
                      actions: [
                        TextButton(
                          child: const Text('OK'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  );
                }
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
```

3. Sesuaikan `main.dart`:
```dart
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:pokedex_mobile/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) {
        CookieRequest request = CookieRequest();
        return request;
      },
      child: MaterialApp(
          title: 'Pokedex Mobile',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
            useMaterial3: true,
          ),
          home: const LoginPage()),
    );
  }
}
```

### Mengintegrasikan sistem autentikasi Django dengan proyek tugas Flutter.
1. Jalankan `python manage.py startappapp authentication` untuk membuat app baru yang bernama `authentication`.

2. Tambahkan `authentication` ke `INSTALLED_APPS` pada *red-s-inventory* `settings.py`.

3. `pip install django-cors-headers` untuk menginstal _library_ yang dibutuhkan.

4. Tambahkan `corsheaders` ke `INSTALLED_APPS` pada *red-s-inventory* `settings.py`.

5. Tambahkan `corsheaders.middleware.CorsMiddleware` pada *red-s-inventory* `settings.py`.

6. Tambahkan beberapa variabel berikut ini pada *red-s-inventory* `settings.py`.

    ```python
    CORS_ALLOW_ALL_ORIGINS = True
    CORS_ALLOW_CREDENTIALS = True
    CSRF_COOKIE_SECURE = True
    SESSION_COOKIE_SECURE = True
    CSRF_COOKIE_SAMESITE = 'None'
    SESSION_COOKIE_SAMESITE = 'None'
    ```
    
7. Membuat metode _view_ untuk login dan logout pada `authentication/views.py`.

```python
import json
from django.shortcuts import render
from django.contrib.auth import authenticate, login as auth_login
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
from django.contrib.auth import logout as auth_logout

@csrf_exempt
def login(request):
    username = request.POST['username']
    password = request.POST['password']
    user = authenticate(username=username, password=password)
    if user is not None:
        if user.is_active:
            auth_login(request, user)
            # Status login sukses.
            return JsonResponse({
                "username": user.username,
                "status": True,
                "message": "Login sukses!"
                # Tambahkan data lainnya jika ingin mengirim data ke Flutter.
            }, status=200)
        else:
            return JsonResponse({
                "status": False,
                "message": "Login gagal, akun dinonaktifkan."
            }, status=401)

    else:
        return JsonResponse({
            "status": False,
            "message": "Login gagal, periksa kembali email atau kata sandi."
        }, status=401)
    
@csrf_exempt
def logout(request):
    username = request.user.username

    try:
        auth_logout(request)
        return JsonResponse({
            "username": username,
            "status": True,
            "message": "Logout berhasil!"
        }, status=200)
    except:
        return JsonResponse({
        "status": False,
        "message": "Logout gagal."
        }, status=401)
```

8. Membuat _file_ `urls.py` pada folder `authentication` dan menambahkan URL _routing_ terhadap fungsi yang sudah dibuat dengan _endpoint_ `login/`.

    ```python
	from django.urls import path
	from authentication.views import login
	
	app_name = 'authentication'
	
	urlpatterns = [
	    path('login/', login, name='login'),
	    path('logout/', login, name='logout'),
	]
    ```

9. Terakhir, tambahkan `path('auth/', include('authentication.urls')),` pada file `red-s-inventory/urls.py`.

### Membuat model kustom sesuai dengan proyek aplikasi Django.
Akses data json pada aplikasi dan masukkan pada `lib/models/pokedex_models.dart`
```dart
import 'dart:convert';

List<Item> itemFromJson(String str) => List<Item>.from(json.decode(str).map((x) => Item.fromJson(x)));

String itemToJson(List<Item> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Item {
    String model;
    int pk;
    Fields fields;

    Item({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        model: json["model"],
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
    );

    Map<String, dynamic> toJson() => {
        "model": model,
        "pk": pk,
        "fields": fields.toJson(),
    };
}

class Fields {
    int user;
    String name;
    DateTime dateAdded;
    int amount;
    String description;

    Fields({
        required this.user,
        required this.name,
        required this.dateAdded,
        required this.amount,
        required this.description,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        name: json["name"],
        dateAdded: DateTime.parse(json["date_added"]),
        amount: json["amount"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "user": user,
        "name": name,
        "date_added": "${dateAdded.year.toString().padLeft(4, '0')}-${dateAdded.month.toString().padLeft(2, '0')}-${dateAdded.day.toString().padLeft(2, '0')}",
        "amount": amount,
        "description": description,
    };
}
```

### Membuat halaman yang berisi daftar semua item yang terdapat pada endpoint JSON di Django yang telah kamu deploy.
Buat file `lib/screens/pokedex_show.dart` dan masukkan kode:
```dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pokedex_mobile/models/pokedex_models.dart';
import 'package:pokedex_mobile/widgets/left_drawer.dart';

class PokeListPage extends StatefulWidget {
  const PokeListPage({Key? key}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<PokeListPage> {
  Future<List<Item>> fetchProduct() async {
    var url = Uri.parse('http://http://tegar-wahyu-tugas.pbp.cs.ui.ac.id/json/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    // melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // melakukan konversi data json menjadi object Item
    List<Item> listProduct = [];
    for (var d in data) {
      if (d != null) {
        listProduct.add(Item.fromJson(d));
      }
    }
    return listProduct;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Pokemon'),
        ),
        drawer: const LeftDrawer(),
        body: FutureBuilder(
            future: fetchProduct(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return const Center(child: CircularProgressIndicator());
              } else {
                if (!snapshot.hasData) {
                  return const Column(
                    children: [
                      Text(
                        "Tidak ada data Pokemon.",
                        style:
                            TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                      ),
                      SizedBox(height: 8),
                    ],
                  );
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (_, index) => Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${snapshot.data![index].fields.name}",
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text("${snapshot.data![index].fields.amount}"),
                                const SizedBox(height: 10),
                                Text(
                                    "${snapshot.data![index].fields.description}")
                              ],
                            ),
                          ));
                }
              }
            }));
  }
}
```

### Membuat halaman detail untuk setiap item yang terdapat pada halaman daftar Item.
1. Buat file `screens/pokedex_detail.dart` yangf berisi:
```dart
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
```

2. Pada file `screens/pokedex_show.dart` tambahkan kode berikut:
```dart
...
return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (_, index) => InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DetailPokemonPage(item: snapshot.data![index]),
                          ),
                        );
                      },
...
```