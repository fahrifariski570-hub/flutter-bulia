import 'package:crud_reinno/halaman_produk.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class TambahProduk extends StatefulWidget {
  final Map ListData;
  const TambahProduk({super.key, required this.ListData});

  @override
  State<TambahProduk> createState() => _TambahProdukState();
}

class _TambahProdukState extends State<TambahProduk> {
  final formkey = GlobalKey<FormState>();
  TextEditingController nama_produk = TextEditingController();
  TextEditingController harga_produk = TextEditingController();

  Future<bool> _save() async {
    final respon = await http.post(
      Uri.parse('http://localhost/api_dannys/create.php'),
      body: {
        'nama_produk': nama_produk.text,
        'harga_produk': harga_produk.text,
      },
    );
    if (respon.statusCode == 200) {
      return true;
    } 
      return false;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Produk'),
        backgroundColor: Colors.blue,
      ),
      body: Form(
        key:formkey,
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
                TextFormField(
                  controller: nama_produk,
                  decoration: const InputDecoration(
                    hintText: 'Nama Produk',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  validator: (value) {
                    if ( value!.isEmpty) {
                      return 'Nama Produk tidak boleh kosong';
                    }
                    return null;
                  },
              ),
              SizedBox(height: 10),
              TextFormField(
                  controller: harga_produk,
                  decoration: const InputDecoration(
                    hintText: 'Harga Produk',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  validator: (value) {
                    if ( value!.isEmpty) {
                      return 'Harga Produk tidak boleh kosong';
                    }
                    return null;
                  },
              ),
              SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
                onPressed: () {
                  if (formkey.currentState!.validate()) {
                    _save().then((value) {
                      if (value) {
                        final snackBar = SnackBar(
                          content: Text('Data berhasil disimpan'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else {
                        final snackBar = SnackBar(
                          content: Text('Data gagal disimpan'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                      Navigator.pushAndRemoveUntil(context,MaterialPageRoute(
                          builder: (context) => HalamanProduk()),
                        (route) => false,
                      );
                    }
                    );
                  }
                },
                child: const Text('Simpan'),
              )
            ],
        ),
      )
      )
    );
  }
  }