import 'package:flutter/material.dart';

class DetailProduk extends StatefulWidget {
  final Map listdata;
  const DetailProduk({super.key, required this.listdata});

  @override
  State<DetailProduk> createState() => _DetailProdukState();
}

class _DetailProdukState extends State<DetailProduk> {
  final formKey = GlobalKey<FormState>();
  TextEditingController idproduk = TextEditingController();
  TextEditingController namaproduk = TextEditingController();
  TextEditingController hargaproduk = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Produk'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Card(
          elevation: 12,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: Text('Id Produk'),
                  subtitle: Text(widget.listdata['id_produk']),
                ),
                ListTile(
                  title: Text('Nama Produk'),
                  subtitle: Text(widget.listdata['nama_produk']),
                ),
                ListTile(
                  title: Text('Harga Produk'),
                  subtitle: Text(widget.listdata['harga_produk']),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
