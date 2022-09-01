class DisplayModel {
  List<Data>? data;
  Pagination? pagination;
  String? message;

  DisplayModel({this.data, this.pagination, this.message});

  DisplayModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  int? id;
  Barangbase? barangbase;
  Toko? toko;
  int? stock;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
      this.barangbase,
      this.toko,
      this.stock,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
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

class Pagination {
  int? currentPage;
  String? firstPageUrl;
  Null? prevPageUrl;
  Null? nextPageUrl;
  String? lastPageUrl;
  int? lastPage;
  int? perPage;
  int? total;
  String? path;

  Pagination(
      {this.currentPage,
      this.firstPageUrl,
      this.prevPageUrl,
      this.nextPageUrl,
      this.lastPageUrl,
      this.lastPage,
      this.perPage,
      this.total,
      this.path});

  Pagination.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    firstPageUrl = json['first_page_url'];
    prevPageUrl = json['prev_page_url'];
    nextPageUrl = json['next_page_url'];
    lastPageUrl = json['last_page_url'];
    lastPage = json['last_page'];
    perPage = json['per_page'];
    total = json['total'];
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    data['first_page_url'] = this.firstPageUrl;
    data['prev_page_url'] = this.prevPageUrl;
    data['next_page_url'] = this.nextPageUrl;
    data['last_page_url'] = this.lastPageUrl;
    data['last_page'] = this.lastPage;
    data['per_page'] = this.perPage;
    data['total'] = this.total;
    data['path'] = this.path;
    return data;
  }
}
