import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pondok207/model/api/api_service.dart';
import 'package:pondok207/model/menu/menu_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum MenuViewState {
  none,
  loading,
  error,
}

class MenuViewModel with ChangeNotifier {
  List<Menu> _menu = [];
  List<Menu> get menus => _menu;

  List<Menu> _searchmenu = [];
  List<Menu> get searchMenus => _searchmenu;

  final Color primaryColor = Color.fromRGBO(142, 3, 3, 3);
  final firstTextController = TextEditingController();
  Menu? datamenu;

  MenuViewState _state = MenuViewState.none;
  MenuViewState get state => _state;

  int _banyak = 1;
  getBanyak() => _banyak;

  late SharedPreferences pref;
  var emailuser;

  changeState(MenuViewState s) {
    _state = s;
    notifyListeners();
  }

  String searchTerm = '';

  getAllMenu() async {
    changeState(MenuViewState.loading);
    try {
      final c = await ApiService().getMenuList();
      _menu = c;
      changeState(MenuViewState.none);
      notifyListeners();
    } catch (e) {
      changeState(MenuViewState.error);
      notifyListeners();
    }
  }

  updateSearchTerm(String value) {
    searchTerm = value;
    notifyListeners();
  }

  getMenuById(String id) async {
    changeState(MenuViewState.loading);
    try {
      datamenu = await ApiService().getMenuById(id: id);
      changeState(MenuViewState.none);
      notifyListeners();
    } catch (e) {
      changeState(MenuViewState.error);
      notifyListeners();
    }
  }

  tambahpesan() {
    _banyak++;
    notifyListeners();
  }

  kurangpesan() {
    _banyak--;
    if (_banyak < 1) {
      _banyak = 0;
    }
    notifyListeners();
  }

  searching(BuildContext context, String key) async {
    try {
      final c = await ApiService().getMenuByKey(key: key);
      _searchmenu = c;
      notifyListeners();
    } catch (e) {
      print(e);
      notifyListeners();
    }
  }
}
