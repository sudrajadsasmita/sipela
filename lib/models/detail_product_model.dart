class DetailProductModel {
  int? id;
  Barangbase? barangbase;
  Toko? toko;
  int? stock;
  String? createdAt;
  String? updatedAt;

  DetailProductModel(
      {this.id,
      this.barangbase,
      this.toko,
      this.stock,
      this.createdAt,
      this.updatedAt});

  DetailProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    barangbase = json['barangbase'] != null
        ? new Barangbase.fromJson(json['barangbase'])
        : null;
    toko = json['toko'] != null ? new Toko.fromJson(json['toko']) : null;
    stock = json['stock'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.barangbase != null) {
      data['barangbase'] = this.barangbase!.toJson();
    }
    if (this.toko != null) {
      data['toko'] = this.toko!.toJson();
    }
    data['stock'] = this.stock;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
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
