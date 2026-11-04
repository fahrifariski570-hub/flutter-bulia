import 'halaman_produk.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditProduk extends StatefulWidget {
  final Map ListData;
  const EditProduk({super.key, required this.ListData});

  @override
  State<EditProduk> createState() => _EditProdukState();
}

class _EditProdukState extends State<EditProduk> {
  final formkey=GlobalKey<FormState>();
  TextEditingController id_produk=TextEditingController();
  TextEditingController nama_produk=TextEditingController();
  TextEditingController harga_produk=TextEditingController();

  Future<bool> _edit()async {
    final respon=await http.post(
      Uri.parse('http://localhost/api_pari/edit.php'),
      body: {
        'id_produk': widget.ListData['id_produk'],
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
        title: const Text('edit Produk'),
        backgroundColor: const Color.fromARGB(255, 33, 107, 243),
      ),
      body: Form(
        key: formkey,
        child: Container(
          padding: const EdgeInsets.all(20),
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
                    return 'Nama Produk Tidak Boleh Kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
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
                    return 'Harga Produk Tidak Boleh Kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  if (formkey.currentState!.validate()) {
                    _edit().then((value) {
                      if (value) {
                        final snackBar = SnackBar(
                          content: const Text('produk berhasil di edit'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else {
                        final snackBar = SnackBar(
                          content: const Text('produk gagal di edit'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HalamanProduk(),
                        ),
                        (route) => false,
                      );
                    });
                  }
                },
                child: const Text('edit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}