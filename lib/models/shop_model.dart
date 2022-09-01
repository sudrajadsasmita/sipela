class ShopModel {
  List<Data>? data;
  Pagination? pagination;
  String? message;

  ShopModel({this.data, this.pagination, this.message});

  ShopModel.fromJson(Map<String, dynamic> json) {
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
  String? approvedDate;
  String? requestStatus;
  RequestFrom? requestFrom;
  Barangbase? barangbase;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
      this.approvedDate,
      this.requestStatus,
      this.requestFrom,
      this.barangbase,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    approvedDate = json['approved_date'];
    requestStatus = json['request_status'];
    requestFrom = json['request_from'] != null
        ? new RequestFrom.fromJson(json['request_from'])
        : null;
    barangbase = json['barangbase'] != null
        ? new Barangbase.fromJson(json['barangbase'])
        : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['approved_date'] = this.approvedDate;
    data['request_status'] = this.requestStatus;
    if (this.requestFrom != null) {
      data['request_from'] = this.requestFrom!.toJson();
    }
    if (this.barangbase != null) {
      data['barangbase'] = this.barangbase!.toJson();
    }
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class RequestFrom {
  int? id;
  String? role;
  String? email;
  Null? emailVerifiedAt;
  String? createdAt;
  String? updatedAt;

  RequestFrom(
      {this.id,
      this.role,
      this.email,
      this.emailVerifiedAt,
      this.createdAt,
      this.updatedAt});

  RequestFrom.fromJson(Map<String, dynamic> json) {
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
