class SubmitAproveModel {
  Data? data;
  String? message;

  SubmitAproveModel({this.data, this.message});

  SubmitAproveModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  int? id;
  User? user;
  User? cutomer;
  Transactiondetails? transactiondetails;
  String? statusTransaksi;
  String? statusPengiriman;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
      this.user,
      this.cutomer,
      this.transactiondetails,
      this.statusTransaksi,
      this.statusPengiriman,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    cutomer =
        json['cutomer'] != null ? new User.fromJson(json['cutomer']) : null;
    transactiondetails = json['transactiondetails'] != null
        ? new Transactiondetails.fromJson(json['transactiondetails'])
        : null;
    statusTransaksi = json['status_transaksi'];
    statusPengiriman = json['status_pengiriman'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.cutomer != null) {
      data['cutomer'] = this.cutomer!.toJson();
    }
    if (this.transactiondetails != null) {
      data['transactiondetails'] = this.transactiondetails!.toJson();
    }
    data['status_transaksi'] = this.statusTransaksi;
    data['status_pengiriman'] = this.statusPengiriman;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class User {
  int? id;
  String? role;
  String? email;
  Null? emailVerifiedAt;
  String? createdAt;
  String? updatedAt;

  User(
      {this.id,
      this.role,
      this.email,
      this.emailVerifiedAt,
      this.createdAt,
      this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    role = json['role'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['role'] = this.role;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Transactiondetails {
  int? id;
  Barangtoko? barangtoko;
  Barangbase? barangbase;
  Toko? toko;
  int? quantity;
  int? subtotal;
  String? createdAt;
  String? updatedAt;

  Transactiondetails(
      {this.id,
      this.barangtoko,
      this.barangbase,
      this.toko,
      this.quantity,
      this.subtotal,
      this.createdAt,
      this.updatedAt});

  Transactiondetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    barangtoko = json['barangtoko'] != null
        ? new Barangtoko.fromJson(json['barangtoko'])
        : null;
    barangbase = json['barangbase'] != null
        ? new Barangbase.fromJson(json['barangbase'])
        : null;
    toko = json['toko'] != null ? new Toko.fromJson(json['toko']) : null;
    quantity = json['quantity'];
    subtotal = json['subtotal'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.barangtoko != null) {
      data['barangtoko'] = this.barangtoko!.toJson();
    }
    if (this.barangbase != null) {
      data['barangbase'] = this.barangbase!.toJson();
    }
    if (this.toko != null) {
      data['toko'] = this.toko!.toJson();
    }
    data['quantity'] = this.quantity;
    data['subtotal'] = this.subtotal;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Barangtoko {
  int? id;
  int? barangbaseId;
  int? tokoId;
  int? stock;
  String? createdAt;
  String? updatedAt;
  Barangbase? barangbase;
  Toko? toko;

  Barangtoko(
      {this.id,
      this.barangbaseId,
      this.tokoId,
      this.stock,
      this.createdAt,
      this.updatedAt,
      this.barangbase,
      this.toko});

  Barangtoko.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    barangbaseId = json['barangbase_id'];
    tokoId = json['toko_id'];
    stock = json['stock'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    barangbase = json['barangbase'] != null
        ? new Barangbase.fromJson(json['barangbase'])
        : null;
    toko = json['toko'] != null ? new Toko.fromJson(json['toko']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['barangbase_id'] = this.barangbaseId;
    data['toko_id'] = this.tokoId;
    data['stock'] = this.stock;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.barangbase != null) {
      data['barangbase'] = this.barangbase!.toJson();
    }
    if (this.toko != null) {
      data['toko'] = this.toko!.toJson();
    }
    return data;
  }
}

class Barangbase {
  int? id;
  String? name;
  int? price;
  String? description;
  String? pictureLink;
  String? createdAt;
  String? updatedAt;

  Barangbase(
      {this.id,
      this.name,
      this.price,
      this.description,
      this.pictureLink,
      this.createdAt,
      this.updatedAt});

  Barangbase.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    description = json['description'];
    pictureLink = json['picture_link'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['description'] = this.description;
    data['picture_link'] = this.pictureLink;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Toko {
  int? id;
  String? name;
  String? description;
  int? userId;
  String? createdAt;
  String? updatedAt;

  Toko(
      {this.id,
      this.name,
      this.description,
      this.userId,
      this.createdAt,
      this.updatedAt});

  Toko.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
