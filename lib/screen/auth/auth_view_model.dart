import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pondok207/model/api/api_service.dart';
import 'package:pondok207/model/user/user_model.dart';
import 'package:pondok207/screen/component/alert_item.dart';
import 'package:pondok207/screen/component/navigation_pane.dart';
import 'package:pondok207/screen/component/trasition_item.dart';
import 'package:pondok207/screen/home/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthViewModel extends ChangeNotifier {
  String _nama = '';
  String _email = '';
  String _password = '';
  final Color primaryColor = Color.fromRGBO(142, 3, 3, 3);
  bool isGet = false;
  bool get loading => isGet;

  isNameValid(String name) {
    if (name.isEmpty) {
      return 'Nama tidak boleh kosong!';
    }
    if (name.length >= 3) {
      _nama = name;
      return null;
    } else {
      return 'Nama min 3 char!';
    }
    notifyListeners();
  }

  isEmailValid(String email) {
    RegExp regex = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    if (email.isEmpty) {
      return 'Email tidak boleh kosong!';
    } else if (regex.hasMatch(email)) {
      _email = email;
      return null;
    } else {
      return 'Masukkan email yang valid!';
    }
  }

  isPasswordValid(String password) {
    if (password.isEmpty) {
      return 'Password tidak boleh kosong!';
    }
    if (password.length >= 8) {
      _password = password;
      return null;
    } else {
      return 'Password min 8 char! (${password.length}/8)';
    }
    notifyListeners();
  }

  isvalid(BuildContext context) async {
    User? retrievedUser = await ApiService().getUserByEmail(email: _email);
    if (retrievedUser != null) {
      if (retrievedUser.email == _email) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Email telah terdaftar')),
        );
      }
    } else if (retrievedUser == null || retrievedUser.email != _email) {
      ApiService()
          .authRegister(nama: _nama, email: _email, password: _password);
      AlertSucces(context, "Akun Berhasil didaftarkan!").then(
          (value) => saveSession(context, _email, retrievedUser?.id ?? ''));
    }
    notifyListeners();
  }

  saveSession(BuildContext context, String email, String id) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString("email", email);
    await pref.setString("id", id);
    await pref.setBool("is_login", true);

    Navigator.pushAndRemoveUntil(
      context,
      TransisiHalaman(
          tipe: PageTransitionType.size,
          align: Alignment.center,
          page: NavigationPage()),
      (route) => false,
    );
    notifyListeners();
  }

  cekLogin(BuildContext context, String email, String password) async {
    final login =
        await ApiService().authLogin(email: email, password: password);
    if (login != null) {
      print('id : ${login.id}');
      if (email == login.email && password == login.password) {
        saveSession(
          context,
          email,
          login.id!,
        );
        Navigator.pushAndRemoveUntil(
          context,
          TransisiHalaman(
              tipe: PageTransitionType.size,
              align: Alignment.center,
              page: NavigationPage()),
          (route) => false,
        );
      } else if (email == login.email && password != login.password) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Password anda salah!')),
        );
      } else if (email != login.email && password == login.password) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Email anda salah!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Email dan Password anda salah')),
        );
      }
    }
  }
}
