import 'package:flutter/cupertino.dart';
import 'package:pondok207/model/api/api_service.dart';
import 'package:pondok207/model/keranjang/cart_model.dart';
import 'package:pondok207/model/user/user_model.dart';

class CartViewModel extends ChangeNotifier {
  List<Keranjang> _keranjang = [];
  List<Keranjang> get carts => _keranjang;
  final Color primaryColor = Color.fromRGBO(142, 3, 3, 3);
  User? datauser;

  int _ongkir = 0;
  getOngkir() {
    return _ongkir;
  }

  var _metodeBayar = '';

  getMethod() {
    return _metodeBayar;
  }

  setMethod(String metode) {
    _metodeBayar = metode;
    notifyListeners();
  }

  addKeranjang({required Keranjang data}) {
    _keranjang.add(data);
    notifyListeners();
  }

  int totalharga() {
    int total = 0;
    for (var i = 0; i < _keranjang.length; i++) {
      total += _keranjang[i].harga!;
    }
    return total;
  }

  getUserById(String id) async {
    datauser = await ApiService().getUserById(id: id);
    notifyListeners();
  }

  int totalBayar(int totalharga) {
    int totalbayar = 0;
    if (totalharga < 15000) {
      _ongkir = 3000;
    } else if (totalharga >= 15000 && totalharga < 40000) {
      _ongkir = 6000;
    } else {
      _ongkir = 9000;
    }
    totalbayar = totalharga + _ongkir;
    return totalbayar;
  }

  deleteItem(int index) {
    _keranjang.removeAt(index);
    notifyListeners();
  }
}
