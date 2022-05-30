import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pondok207/model/api/api_service.dart';
import 'package:pondok207/model/user/user_model.dart';

void main() {
  group('Api Service', () {
    test('Get All Menu', () async {
      var menu = await ApiService().getMenuList();
      expect(menu.isNotEmpty, true);
    });

    test('Get Menu By Id', () async {
      var menu = await ApiService().getMenuById(id: '1');
      expect(menu?.nama.toString(), 'Nasi Goreng Telur Dadar');
    });

    test('Get User By Email', () async {
      var user =
          await ApiService().getUserByEmail(email: 'hidayatullahbp@gmail.com');
      expect(user?.name.toString(), 'Hidayatullah Dayat');
    });

    test('Get User By Email', () async {
      var user =
          await ApiService().getUserByEmail(email: 'hidayatullahbp@gmail.com');
      expect(user?.name.toString(), 'Hidayatullah Dayat');
    });
  });
}
