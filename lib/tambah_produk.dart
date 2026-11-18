import 'package:crud_pari/halaman_produk.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TambahProduk extends StatefulWidget {
  const TambahProduk({super.key});

  @override
  State<TambahProduk> createState() => _TambahProdukState();
}

class _TambahProdukState extends State<TambahProduk> {
  final formKey = GlobalKey<FormState>();
  TextEditingController nama_produk = TextEditingController();
  TextEditingController harga_produk = TextEditingController();


Future<bool> _save() async {
  try {
    final respon = await http.post(
      Uri.parse('http://localhost/api_pari/tambah.php'),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Accept': 'application/json',
      },
      body: {
        'nama_produk': nama_produk.text.trim(),
        'harga_produk': harga_produk.text.trim(),
      },
    );

    print('STATUS: ${respon.statusCode}');
    print('RESPONSE: ${respon.body}');

    final data = jsonDecode(respon.body);

    if (respon.statusCode == 200 &&
        data['pesan'] == 'sukses') {
      return true;
    }

    return false;

  } catch (e) {
    print('ERROR API: $e');
    return false;
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Produk'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Form(
        key: formKey,
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              TextFormField(
                controller: nama_produk,
                decoration: InputDecoration(
                  hintText: 'Nama Produk',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Nama Produk tidak boleh kosong';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: harga_produk,
                decoration: InputDecoration(
                  hintText: 'Harga Produk',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Harga Produk tidak boleh kosong';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () async {
                if (!formKey.currentState!.validate()) return;

                final berhasil = await _save();

                if (!mounted) return;

                if (berhasil) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Produk berhasil disimpan'),
                      backgroundColor: Colors.green,
                    ),
                  );

                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HalamanProduk(),
                    ),
                    (route) => false,
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Produk gagal disimpan. Periksa koneksi API.'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
