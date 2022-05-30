import 'package:flutter/cupertino.dart';
import 'package:pondok207/model/api/api_service.dart';
import 'package:pondok207/model/keranjang/pembayaranchek_model.dart';
import 'package:pondok207/model/keranjang/pembayaranker_model.dart';
import 'package:pondok207/model/user/user_model.dart';
import 'package:pondok207/screen/component/alert_item.dart';

enum ProfileViewState {
  none,
  loading,
  error,
}

class ProfileViewModel extends ChangeNotifier {
  User? datauser;
  String _nama = '';
  String _email = '';
  String _phone = '';
  String _alamat = '';
  String _password = '';
  String _passwordulang = '';
  final Color primaryColor = Color.fromRGBO(142, 3, 3, 3);

  ProfileViewState _state = ProfileViewState.none;
  ProfileViewState get state => _state;

  List<PembayaranChek> _pembayaran = [];
  List<PembayaranChek> get CheckoutList => _pembayaran;

  List<PembayaranKer> _pembayaranker = [];
  List<PembayaranKer> get CheckoutListKeranjang => _pembayaranker;

  changeState(ProfileViewState s) {
    _state = s;
    notifyListeners();
  }

  getDataUserById(String id) async {
    changeState(ProfileViewState.loading);
    try {
      datauser = await ApiService().getUserById(id: id);
      changeState(ProfileViewState.none);
      notifyListeners();
    } catch (e) {
      changeState(ProfileViewState.error);
      notifyListeners();
    }
  }

  updateProfile(BuildContext context, User user) {
    ApiService().updateProfile(user);
    AlertSucces(context, "Profile berhasil diperbaharui!")
        .then((value) => Navigator.pop(context));
    notifyListeners();
  }

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

  isPhoneValid(String phone) {
    if (phone.isEmpty) {
      return 'No Hp tidak boleh kosong!';
    }
    if (phone.length >= 12) {
      _phone = phone;
      return null;
    } else {
      return 'No hp min 12 Char! (${phone.length}/12)';
    }
  }

  isAlamatValid(String alamat) {
    if (alamat.isEmpty) {
      return 'Alamat tidak boleh kosong!';
    }
    if (alamat.length >= 5) {
      _alamat = alamat;
      return null;
    } else {
      return 'Alamat min 5 char! (${alamat.length}/5)';
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
  }

  isPasswordUlangValid(String passwordUlang) {
    if (passwordUlang.isEmpty) {
      return 'Password tidak boleh kosong!';
    }
    if (passwordUlang.length >= 8) {
      _passwordulang = passwordUlang;
      return null;
    } else {
      return 'Password min 8 char! (${passwordUlang.length}/8)';
    }
  }

  changePasswordValid(BuildContext context, String pw1, String pw2) {
    if (pw1.contains(pw2)) {
      ApiService().updateProfile(
        User(
          createdAt: datauser?.createdAt ?? 0,
          name: datauser?.name ?? '',
          email: datauser?.email ?? '',
          password: pw1,
          noPhone: datauser?.noPhone ?? '',
          alamat: datauser?.alamat ?? '',
          status: datauser?.status ?? '',
          id: datauser?.id ?? '',
        ),
      );
      AlertSucces(context, "Berhasil").then((value) => Navigator.pop(context));
    } else {
      AlertError(context, "Password tidak sama!");
    }
    notifyListeners();
  }

  getAllPembayaran(String email) async {
    changeState(ProfileViewState.loading);
    try {
      final c = await ApiService().getPembayaranList(email);
      _pembayaran = c;
      changeState(ProfileViewState.none);
      notifyListeners();
    } catch (e) {
      changeState(ProfileViewState.error);
      notifyListeners();
    }
  }
}
