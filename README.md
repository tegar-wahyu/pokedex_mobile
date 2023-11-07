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