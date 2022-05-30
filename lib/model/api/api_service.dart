import 'package:dio/dio.dart';
import 'package:pondok207/model/keranjang/pembayaranchek_model.dart';
import 'package:pondok207/model/keranjang/pembayaranker_model.dart';
import 'package:pondok207/model/menu/menu_model.dart';
import 'package:pondok207/model/user/user_model.dart';

class ApiService {
  List<PembayaranChek>? pembayaranList;
  List<PembayaranKer>? pembayaranListKer;
  List<Menu>? menuList;
  final Dio _dio = Dio();
  final _baseUrl = 'https://61ac6ee5264ec200176d448d.mockapi.io/api/';

  //AUTENTIKASI
  //Register
  authRegister(
      {required String nama,
      required String email,
      required String password}) async {
    var data = {
      "name": nama,
      "email": email,
      "password": password,
      "noPhone": '',
      "alamat": '',
      "status": 'Aktif',
    };
    Response response = await _dio.post(_baseUrl + "user", data: data);
  }

  //Login
  Future<User> authLogin(
      {required String email, required String password}) async {
    var data = {
      "email": email,
      "password": password,
    };
    try {
      Response response =
          await _dio.get(_baseUrl + "user", queryParameters: data);
      return User.fromJson(response.data[0]);
    } catch (e) {
      return User.fromJson({});
    }
  }

  Future<User?> getUserById({required String id}) async {
    User? dataUser;
    try {
      Response response = await _dio.get(_baseUrl + 'user/$id');
      dataUser = User.fromJson(response.data);
    } catch (e) {
      print(e);
    }
    return dataUser;
  }

  Future<User?> getUserByEmail({required String email}) async {
    User? dataUser;
    try {
      Response response = await _dio.get(_baseUrl + 'user?email=$email');
      dataUser = User.fromJson(response.data[0]);
    } catch (e) {
      print(e);
    }
    return dataUser;
  }

  Future<bool> updateProfile(User data) async {
    final response =
        await _dio.put(_baseUrl + "user/${data.id}", data: data.toJson());
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  //HOME
  //Get All Menu
  Future<List<Menu>> getMenuList() async {
    Response<List<dynamic>> response = await _dio.get(_baseUrl + "menu");
    if (response.statusCode == 200) {
      var getMenuData = response.data as List;
      menuList = getMenuData.map((e) => Menu.fromJson(e)).toList();
      return menuList ?? [];
    }
    return [];
  }

  Future<List<Menu>> getMenuByKey({required String key}) async {
    Response<List<dynamic>> response =
        await _dio.get(_baseUrl + 'menu?search=$key');
    if (response.statusCode == 200) {
      var getMenuData = response.data as List;
      menuList = getMenuData.map((e) => Menu.fromJson(e)).toList();
      return menuList ?? [];
    }
    return [];
  }

  //Get Menu By Id
  Future<Menu?> getMenuById({required String id}) async {
    Menu? getMenu;
    try {
      Response response = await _dio.get(_baseUrl + 'menu/$id');
      getMenu = Menu.fromJson(response.data);
    } catch (e) {
      print('Error Get data : $e');
    }
    return getMenu;
  }

  //PEMBAYARANCHEK
  //Service Bayar sekarang
  Future<bool> bayar(PembayaranChek data) async {
    Response response =
        await _dio.post(_baseUrl + "pembayaranchek", data: data.toJson());
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<PembayaranChek>> getPembayaranList(String email) async {
    Response<List<dynamic>> response =
        await _dio.get(_baseUrl + "pembayaranchek?email=$email");
    if (response.statusCode == 200) {
      var getPembayaranData = response.data as List;
      pembayaranList =
          getPembayaranData.map((e) => PembayaranChek.fromJson(e)).toList();
      return pembayaranList ?? [];
    }
    return [];
  }

  //PEMBAYARANCHEK
  //Service Bayar sekarang
  Future<bool> bayarker(PembayaranKer data) async {
    Response response =
        await _dio.post(_baseUrl + "pembayaranker", data: data.toJson());
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<PembayaranKer>> getPembayaranKerList() async {
    Response<List<dynamic>> response =
        await _dio.get(_baseUrl + "pembayaranker");
    if (response.statusCode == 200) {
      var getPembayaranData = response.data as List;
      pembayaranListKer =
          getPembayaranData.map((e) => PembayaranKer.fromJson(e)).toList();
      return pembayaranListKer ?? [];
    }
    return [];
  }
}
