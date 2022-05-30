import 'package:flutter/cupertino.dart';
import 'package:pondok207/model/api/api_service.dart';
import 'package:pondok207/model/keranjang/pembayaranchek_model.dart';
import 'package:pondok207/model/keranjang/pembayaranker_model.dart';
import 'package:pondok207/model/user/user_model.dart';
import 'package:pondok207/screen/component/alert_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum PesananViewState {
  none,
  loading,
  error,
}

class PesananViewModel extends ChangeNotifier {
  final Color primaryColor = Color.fromRGBO(142, 3, 3, 3);

  PesananViewState _state = PesananViewState.none;
  PesananViewState get state => _state;

  List<PembayaranChek> _pembayaran = [];
  List<PembayaranChek> get CheckoutList => _pembayaran;

  changeState(PesananViewState s) {
    _state = s;
    notifyListeners();
  }

  getAllPembayaran(String emailPref) async {
    changeState(PesananViewState.loading);
    try {
      final c = await ApiService().getPembayaranList(emailPref);
      _pembayaran = c;
      changeState(PesananViewState.none);
      notifyListeners();
    } catch (e) {
      changeState(PesananViewState.error);
      notifyListeners();
    }
  }
}
