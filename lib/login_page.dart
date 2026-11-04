import 'dart:convert';

import 'package:crud_pari/DashboardAdmin.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  bool loading = false;
  bool hidePassword = true;

  final String url = 'http://localhost/api_fathir/login.php';

  Future<void> login() async {
    if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Username dan password harus diisi')),
      );
      return;
    }
    setState(() {
      loading = true;
    });

    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          'username': usernameController.text.trim(),
          'password': passwordController.text,
        },
      );
      final hasil = jsonDecode(response.body);
      if (!mounted) return;

      if (response.statusCode == 200 && hasil['status'] == true) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Dashboardadmin(
              nama: hasil['data']['nama']),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(hasil['pesan'] ?? 'login gagal')),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('tidak dapat terhubung ke server')),
      );
    } finally {
      if (!mounted) {
        setState(() {
          loading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Card(elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              const Icon(Icons.admin_panel_settings,
              size: 80,
              color: Colors.blue,
              ),
              const SizedBox(height: 15,),
             const Text('Halaman login',
             style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold
             ),
             ),
              const SizedBox(height: 15),
              TextFormField(
                controller: usernameController,
                decoration: const InputDecoration(
                  labelText: 'username',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
              ),

               const SizedBox(height: 15),
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(
                  labelText: 'username',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon:Icon(
                   hidePassword
                    ?Icons.visibility
                    :Icons.visibility_off
                    ),
                    onPressed: (){
                      setState(() {
                        hidePassword=!hidePassword;
                      });
                    }
                  ),
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(onPressed: loading ? null:login,
                 child: loading 
                 ? const CircularProgressIndicator(
                  color: Colors.white,
                  )
                  :const Text(
                    'Login',
                    style: TextStyle(fontSize: 16),
                  )
                 ),
              ),
            ],
          ),
          ),
          ),
        ),
      ),
    );
  }
}