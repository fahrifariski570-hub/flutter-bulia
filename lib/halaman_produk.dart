import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'detail_produk.dart';
import 'edit_produk.dart';
import 'tambah_produk.dart';

class HalamanProduk extends StatefulWidget {
  const HalamanProduk({super.key});

  @override
  State<HalamanProduk> createState() => _HalamanProdukState();
}

class _HalamanProdukState extends State<HalamanProduk> {
  List _listdata = [];
  bool _loading = true;

  Future<void> _getdata() async {
    try {
      final respon = await http.get(
        Uri.parse('http://localhost/api_pari/tampil.php'),
      );

      if (respon.statusCode == 200) {
        final data = jsonDecode(respon.body);
        setState(() {
          _listdata = data;
        });
      } else {
        print('Failed to load data:${respon.statusCode}');
      }
    } catch (e) {
      print('Error:$e');
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  Future<void> deleteProduk(String idProduk) async {
    final respon = await http.post(
      Uri.parse('http://localhost/api_pari/hapus.php'),
      body: {'id_produk': idProduk},
    );
    if (respon.statusCode == 200) {
      setState(() {
        _listdata.removeWhere((item) => item['id_produk'] == idProduk);
      });
      final snackBar = SnackBar(content: Text('Produk berhasil dihapus'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      final snackBar = SnackBar(content: Text('Gagal menghapus produk'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  void initState() {
    super.initState();
    _getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Halaman Produk'),
        backgroundColor: Colors.brown,
      ),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _listdata.length,
              itemBuilder: (context, index) {
                return Card(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailProduk(
                            listdata: {
                              'id_produk': _listdata[index]['id_produk'],
                              'nama_produk': _listdata[index]['nama_produk'],
                              'harga_produk': _listdata[index]['harga_produk'],
                            },
                          ),
                        ),
                      );
                    },
                    child: ListTile(
                      title: Text(_listdata[index]['nama_produk'].toString()),
                      subtitle: Text(
                        _listdata[index]['harga_produk'].toString(),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.brown),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditProduk(
                                    listdata: {
                                      'id_produk':
                                          _listdata[index]['id_produk'],
                                      'nama_produk':
                                          _listdata[index]['nama_produk'],
                                      'harga_produk':
                                          _listdata[index]['harga_produk'],
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Konfirmasi'),
                                    content: Text(
                                      'Apakah Anda yakin akan menghapus data ini?',
                                    ),
                                    actions: [
                                      TextButton(
                                        child: Text('Batal'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      TextButton(
                                        child: Text('Hapus'),
                                        onPressed: () {
                                          deleteProduk(
                                            _listdata[index]['id_produk'],
                                          );
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: Text('+', style: TextStyle(fontSize: 20)),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TambahProduk()),
          );
        },
      ),
    );
  }
}
