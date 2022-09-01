class TransactionDetailModel {
  Data? data;
  String? message;

  TransactionDetailModel({this.data, this.message});

  TransactionDetailModel.fromJson(Map<String, dynamic> json) {
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
  Barangtoko? barangtoko;
  Barangbase? barangbase;
  String? quantity;
  int? subtotal;
  Transaction? transaction;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
      this.barangtoko,
      this.barangbase,
      this.quantity,
      this.subtotal,
      this.transaction,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    barangtoko = json['barangtoko'] != null
        ? new Barangtoko.fromJson(json['barangtoko'])
        : null;
    barangbase = json['barangbase'] != null
        ? new Barangbase.fromJson(json['barangbase'])
        : null;
    quantity = json['quantity'];
    subtotal = json['subtotal'];
    transaction = json['transaction'] != null
        ? new Transaction.fromJson(json['transaction'])
        : null;
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
    data['quantity'] = this.quantity;
    data['subtotal'] = this.subtotal;
    if (this.transaction != null) {
      data['transaction'] = this.transaction!.toJson();
    }
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

  Barangtoko(
      {this.id,
      this.barangbaseId,
      this.tokoId,
      this.stock,
      this.createdAt,
      this.updatedAt,
      this.barangbase});

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

class Transaction {
  int? id;
  int? userId;
  String? statusTransaksi;
  String? statusPengiriman;
  String? createdAt;
  String? updatedAt;

  Transaction(
      {this.id,
      this.userId,
      this.statusTransaksi,
      this.statusPengiriman,
      this.createdAt,
      this.updatedAt});

  Transaction.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    statusTransaksi = json['status_transaksi'];
    statusPengiriman = json['status_pengiriman'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['status_transaksi'] = this.statusTransaksi;
    data['status_pengiriman'] = this.statusPengiriman;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
