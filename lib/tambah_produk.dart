import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class TambahProduk extends StatefulWidget {
  const new({super.key});

  @override
  State<TambahProduk> createState() => _TambahProdukState();
}

class _TambahProdukState extends State<TambahProduk> {
  final formkey = GlobalKey<FormState>();
  TextEditingController id_produk = TextEditingController();
  TextEditingController nama_produk = TextEditingController();
  TextEditingController harga_produk = TextEditingController();

  Future<bool> _save()async{
    final respon =await http.post(
      Uri.parse('http://localhost/api_pari/tambah.php'),
      body:{
        'nama_produk':nama_produk.text,
        'harga_produk':harga_produk.text,
      },
    );
    if (respon.statusCode == 200){
      return true;
    }
    return false;
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Tambah produk'),
        backgroundColor: Colors.blue,
      ),
      body: Form(
        key:formkey,
        child: Container(
          padding: ,
        ),
      ),
    );
  }
}