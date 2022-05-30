import 'package:pondok207/model/keranjang/pembayaranchek_model.dart';

class PembayaranKer {
  List<PembayaranChek>? data;
  String? tanggalpesan;
  String? id;

  PembayaranKer({this.data, this.tanggalpesan, this.id});

  PembayaranKer.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <PembayaranChek>[];
      json['data'].forEach((v) {
        data!.add(new PembayaranChek.fromJson(v));
      });
    }
    tanggalpesan = json['tanggalpesan'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['tanggalpesan'] = this.tanggalpesan;
    data['id'] = this.id;
    return data;
  }
}
