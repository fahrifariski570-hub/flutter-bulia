import 'package:flutter/material.dart';

class DetailProduk extends StatefulWidget {
  final Map ListData;
  const DetailProduk({super.key, required this.ListData});

  @override
  State<DetailProduk> createState() => _DetailProdukState();
}

class _DetailProdukState extends State<DetailProduk> {
  final formkey = GlobalKey<FormState>();
  TextEditingController id_produk = TextEditingController();
  TextEditingController nama_produk = TextEditingController();
  TextEditingController harga_produk = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Produk'),
        backgroundColor: Colors.blue,
      ),
      body:Padding(
        padding: const EdgeInsets.all(30),
        child: Card(
          elevation: 8,
          child: Padding(
            padding : const EdgeInsets.all(16),
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                ListTile(
                  title: const Text('ID Produk'),
                  subtitle: Text(widget.ListData['id_produk']),
                ),
                ListTile(
                  title: const Text('Nama Produk'),
                  subtitle: Text(widget.ListData['nama_produk']),
                ),
                ListTile(
                  title: const Text('Harga Produk'),
                  subtitle: Text(widget.ListData['harga_produk']),
                ),
              ]
            )
          ),
        ),
      )
      );
  }
}