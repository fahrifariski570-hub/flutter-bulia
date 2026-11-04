import 'dart:convert';
import 'tambah_produk.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'detail_produk.dart';
import 'edit_produk.dart';


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
      final respon =
          await http.get(Uri.parse('http://localhost/api_pari/tampil.php'));
      if (respon.statusCode == 200) {
        final data = jsonDecode(respon.body);
        setState(() {
          _listdata = data;
          _loading = false;
        });
      } else {
        print('failed to load data:${respon.statusCode}');
        setState(() {
          _loading = false;
        });
      }
    } catch (e) {
      print('Error:$e');
      setState(() {
        _loading = false;
      });
    }
  }

  Future<void> deleteproduk(String idproduk) async {
    final respon = await http.post(
        Uri.parse('http://localhost/api_pari/delete.php'),
        body: {'id_produk': idproduk});
    if (respon.statusCode == 200) {
      setState(() {
        _listdata.removeWhere((item) => item['id_produk'] == idproduk);
      });
      final snackBar = SnackBar(content: Text('produk berhasil di hapus'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      final snackBar = SnackBar(content: Text('gagal menghapus produk'));
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
        title: const Text('Halaman Produk'),
        backgroundColor: Colors.blue,
      ),
      body: _loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
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
                            ListData: {
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
                      subtitle:
                          Text(_listdata[index]['harga_produk'].toString()),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditProduk(
                                    ListData: {
                                      'id_produk': _listdata[index]
                                          ['id_produk'],
                                      'nama_produk': _listdata[index]
                                          ['nama_produk'],
                                      'harga_produk': _listdata[index]
                                          ['harga_produk'],
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('konfirmasi'),
                                    content: const Text(
                                        'apakah anda yakin akan menghapus data ini'),
                                    actions: [
                                      TextButton(
                                        child: const Text('batal'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      TextButton(
                                        child: const Text('hapus'),
                                        onPressed: () {
                                          deleteproduk(
                                              _listdata[index]['id_produk']);
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
                child: const Text(
                 '+',
                  style: TextStyle(fontSize: 20),
                 ),
                  onPressed: () {
                  Navigator.push(
                       context,
                 MaterialPageRoute(builder: (context) => const TambahProduk()),
          );
        },
      ),
    );
  }
}