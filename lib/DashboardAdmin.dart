import 'package:crud_pari/halaman_produk.dart';
import 'package:crud_pari/login_page.dart';
import 'package:flutter/material.dart';

class Dashboardadmin extends StatefulWidget {
  final String nama;

  const Dashboardadmin({super.key, required this.nama});

  @override
  State<Dashboardadmin> createState() => _DashboardadminState();
}

class _DashboardadminState extends State<Dashboardadmin> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text("DashBoard Admin"),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.black,
        automaticallyImplyLeading: false,
        actions:[
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: (){
              Navigator.pushAndRemoveUntil(context,
               MaterialPageRoute
               (builder:(context)=>const LoginPage(),
               ),
                (route) => false
                );  
              },
            )
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width:double.infinity,
                padding: const EdgeInsets.all(22),
                decoration:BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.account_circle,
                      size: 50,
                      color: Colors.black,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'selamat Datang',
                      style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      ),
                  
                    ),
                    Text(widget.nama,
                      style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text('Administrator Aplikasi Produk',
                    style: TextStyle(color: Colors.black,                    ),
                    ),
                    const SizedBox(height: 5),
                    Text('Dashboard Utama',
                      style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Card(
                      child: ListTile(
                        leading: const CircleAvatar(
                          backgroundColor: Colors.orange,
                          child: Icon(
                            Icons.inventory,
                            color: Colors.black,
                          )
                        ),
                        title: const Text('Data Produk',
                        style: TextStyle(
                        fontWeight: FontWeight.bold,
                        ),
                        ),
                        subtitle: const Text('Kelola Data Produk'),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: (){
                          Navigator.push(context, 
                           MaterialPageRoute(builder: (context) => const HalamanProduk(),
                           ),
                          );
                        },
                      )
                    ),
                    const SizedBox(height: 5),
                    Card(
                      child: ListTile(
                        leading: const CircleAvatar(
                          backgroundColor: Colors.orange,
                          child: Icon(
                            Icons.add,
                            color: Colors.black,
                          )
                        ),
                        title: const Text('Tambah Produk',
                        style: TextStyle(
                        fontWeight: FontWeight.bold,
                        ),
                        ),
                        subtitle: const Text('Menambah Produk Baru'),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: (){
                          Navigator.push(context, 
                           MaterialPageRoute(builder: (context) => const HalamanProduk(),
                           ),
                          );
                        },
                      )
                    ),
                    const SizedBox(height: 30),
                    const Center(
                      child: Text('aplikasi manajemen',
                      style: TextStyle(color: Colors.amber),),)
                  ],
                ),
              )
            ],
          )          
        )
      );
    }
  }
