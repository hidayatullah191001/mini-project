class PembayaranChek {
  String? nama;
  String? gambar;
  String? totalbayar;
  String? banyak;
  String? namauser;
  String? alamat;
  String? email;
  String? status;
  String? id;
  String? metode;
  String? datetime;

  PembayaranChek(
      {this.nama,
      this.gambar,
      this.totalbayar,
      this.banyak,
      this.namauser,
      this.alamat,
      this.email,
      this.status,
      this.id,
      this.metode,
      this.datetime});

  PembayaranChek.fromJson(Map<String, dynamic> json) {
    nama = json['nama'];
    gambar = json['gambar'];
    totalbayar = json['totalbayar'];
    banyak = json['banyak'];
    namauser = json['namauser'];
    alamat = json['alamat'];
    email = json['email'];
    status = json['status'];
    id = json['id'];
    metode = json['metode'];
    datetime = json['datetime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nama'] = this.nama;
    data['gambar'] = this.gambar;
    data['totalbayar'] = this.totalbayar;
    data['banyak'] = this.banyak;
    data['namauser'] = this.namauser;
    data['alamat'] = this.alamat;
    data['email'] = this.email;
    data['status'] = this.status;
    data['id'] = this.id;
    data['metode'] = this.metode;
    data['datetime'] = this.datetime;
    return data;
  }
}
