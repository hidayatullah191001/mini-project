import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pondok207/model/api/api_service.dart';
import 'package:pondok207/screen/auth/auth_view_model.dart';
import 'package:pondok207/screen/component/navigation_pane.dart';
import 'package:pondok207/screen/auth/register_screen.dart';
import 'package:pondok207/screen/component/trasition_item.dart';
import 'package:pondok207/screen/home/menu_view_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoggedIn = false;
  String email = '';

  late TextEditingController emailController;
  late TextEditingController passwordController;

  bool? passwordVisible;
  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();

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
            child: SingleChildScrollView(
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
                      'Masuk dengan akun kamu',
                      style: TextStyle(fontSize: 16),
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
                      enableSuggestions: false,
                      autocorrect: false,
                      controller: passwordController,
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
                    ),
                    const SizedBox(
                      height: 31,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          authmodelView.cekLogin(context, emailController.text,
                              passwordController.text);
                        }
                      },
                      child: const Text('Sign In'),
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
                          Navigator.push(
                            context,
                            TransisiHalaman(
                                tipe: PageTransitionType.fade,
                                page: RegisterScreen()),
                          );
                        },
                        child: const Text('Belum punya akun? daftar disini'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
