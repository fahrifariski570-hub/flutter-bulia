import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'halaman_produk.dart';

class EditProduk extends StatefulWidget {
  final Map listdata;
  const EditProduk({super.key, required this.listdata});

  @override
  State<EditProduk> createState() => _EditProdukState();
}

class _EditProdukState extends State<EditProduk> {
  final formKey = GlobalKey<FormState>();
  TextEditingController id_produk = TextEditingController();
  TextEditingController nama_produk = TextEditingController();
  TextEditingController harga_produk = TextEditingController();

  Future<bool> _edit() async {
    final respon = await http.post(
      Uri.parse('http://localhost/api_pari/edit.php'),
      body: {
        'id_produk': id_produk.text,
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
    id_produk.text = widget.listdata['id_produk'];
    nama_produk.text = widget.listdata['nama_produk'];
    harga_produk.text = widget.listdata['harga_produk'];
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Produk'),
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
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    _edit().then((value) {
                      if (value) {
                        final snackBar = SnackBar(
                          content: const Text('Produk berhasil diedit'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else {
                        final snackBar = SnackBar(
                          content: const Text('Produk gagal diedit'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HalamanProduk(),
                        ),
                        (route) => false,
                      );
                    });
                  }
                },
                child: Text('Edit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
