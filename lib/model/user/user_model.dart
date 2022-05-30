class User {
  int? createdAt;
  String? name;
  String? email;
  String? password;
  String? noPhone;
  String? alamat;
  String? status;
  String? id;

  User(
      {this.createdAt,
      this.name,
      this.email,
      this.password,
      this.noPhone,
      this.alamat,
      this.status,
      this.id});

  User.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    noPhone = json['noPhone'];
    alamat = json['alamat'];
    status = json['status'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdAt'] = this.createdAt;
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['noPhone'] = this.noPhone;
    data['alamat'] = this.alamat;
    data['status'] = this.status;
    data['id'] = this.id;
    return data;
  }
}
