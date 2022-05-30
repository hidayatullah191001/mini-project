import 'package:flutter/material.dart';
import 'package:pondok207/model/api/api_service.dart';
import 'package:pondok207/model/user/user_model.dart';
import 'package:pondok207/screen/auth/auth_view_model.dart';
import 'package:pondok207/screen/home/menu_view_model.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late TextEditingController namaController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  bool isGet = false;
  bool? passwordVisible;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordVisible = false;
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authmodelView = Provider.of<AuthViewModel>(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: CircleAvatar(
                      backgroundImage: AssetImage('images/logo.png'),
                      radius: 100,
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Daftar akun baru kamu',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    key: Key('name'),
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                    decoration: InputDecoration(
                      hintText: "Nama Lengkap...",
                      fillColor: Colors.grey[300],
                      filled: true,
                      isDense: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none),
                    ),
                    validator: (nama) => authmodelView.isNameValid(nama!),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    key: Key('email'),
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: "Email...",
                      fillColor: Colors.grey[300],
                      filled: true,
                      isDense: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none),
                    ),
                    validator: (email) => authmodelView.isEmailValid(email!),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    key: Key('password'),
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                    obscureText: !passwordVisible!,
                    decoration: InputDecoration(
                      hintText: "Password...",
                      fillColor: Colors.grey[300],
                      filled: true,
                      isDense: true,
                      suffixIcon: IconButton(
                        color: authmodelView.primaryColor,
                        icon: Icon(
                          // Based on passwordUlangVisible state choose the icon
                          passwordVisible!
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: authmodelView.primaryColor,
                        ),
                        onPressed: () {
                          // Update the state i.e. toogle the state of passwordVisible variable
                          setState(() {
                            passwordVisible = !passwordVisible!;
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none),
                    ),
                    validator: (password) =>
                        authmodelView.isPasswordValid(password!),
                  ),
                  const SizedBox(
                    height: 31,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        authmodelView.isvalid(context);
                      }
                    },
                    child: const Text('Sign Up'),
                    style: ElevatedButton.styleFrom(
                      primary: authmodelView.primaryColor,
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 45,
                  ),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Sudah punya akun? masuk disini'),
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
