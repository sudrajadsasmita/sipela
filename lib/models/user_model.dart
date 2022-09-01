class UserModel {
  Data? data;
  String? token;

  UserModel(jsonDecode, {this.data, this.token});

  UserModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['token'] = token;
    return data;
  }
}

class Data {
  User? user;

  Data({this.user});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? email;
  String? role;
  String? createdAt;
  String? updatedAt;
  Profil? profil;

  User(
      {this.id,
      this.email,
      this.role,
      this.createdAt,
      this.updatedAt,
      this.profil});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    role = json['role'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    profil =
        json['profil'] != null ? new Profil.fromJson(json['profil']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['role'] = this.role;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.profil != null) {
      data['profil'] = this.profil!.toJson();
    }
    return data;
  }
}

class Profil {
  String? name;
  String? address;
  String? gender;
  String? dateOfBirth;
  String? whatsapp;
  int? userId;
  String? updatedAt;
  String? createdAt;
  int? id;

  Profil(
      {this.name,
      this.address,
      this.gender,
      this.dateOfBirth,
      this.whatsapp,
      this.userId,
      this.updatedAt,
      this.createdAt,
      this.id});

  Profil.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    address = json['address'];
    gender = json['gender'];
    dateOfBirth = json['date_of_birth'];
    whatsapp = json['whatsapp'];
    userId = json['user_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['address'] = this.address;
    data['gender'] = this.gender;
    data['date_of_birth'] = this.dateOfBirth;
    data['whatsapp'] = this.whatsapp;
    data['user_id'] = this.userId;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
