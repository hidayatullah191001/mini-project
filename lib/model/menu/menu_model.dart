class Menu {
  int? createdAt;
  String? nama;
  int? harga;
  String? gambar;
  String? id;

  Menu({this.createdAt, this.nama, this.harga, this.gambar, this.id});

  Menu.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    nama = json['nama'];
    harga = json['harga'];
    gambar = json['gambar'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdAt'] = this.createdAt;
    data['nama'] = this.nama;
    data['harga'] = this.harga;
    data['gambar'] = this.gambar;
    data['id'] = this.id;
    return data;
  }
}
