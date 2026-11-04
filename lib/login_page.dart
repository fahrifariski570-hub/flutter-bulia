import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const new({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  bool loading = false;
  bool hidePassword = true;
  final String url='http://localhost/api_pari/login.php';
  Future<void> login() async {
    if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Username dan Password tidak boleh kosong')),
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
          'username': usernameController.text,
          'password': passwordController.text,
        },
      );
      final hasil = jsonDecode(response.body);
      if (!mounted) return;

      if (response.statusCode == 200 && hasil['status'] == true) {
        Navigator.pushReplacementNamed(context, MaterialPageRoute(builder: (context)=> Dashboardadmin(
          nama:hasil['data']['nama'],
        ),
        ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(content: Text(hasil['pesan']??'Login gagal')),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('tidak dapat terhubung ke server')),
      );
    } 
  }
    
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}