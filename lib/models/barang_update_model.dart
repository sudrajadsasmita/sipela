class BarangUpdateModel {
  String? barangId;
  String? name;
  String? description;
  String? price;
  String? pictureLink;

  BarangUpdateModel(
      {this.barangId,
      this.name,
      this.description,
      this.price,
      this.pictureLink});

  BarangUpdateModel.fromJson(Map<String, dynamic> json) {
    barangId = json['barang_id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    pictureLink = json['picture_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['barang_id'] = this.barangId;
    data['description'] = this.description;
    data['price'] = this.price;
    data['picture_link'] = this.pictureLink;
    return data;
  }
}
