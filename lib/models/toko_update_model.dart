class TokoUpdateModel {
  String? name;
  String? description;

  TokoUpdateModel({
    this.name,
    this.description,
  });

  TokoUpdateModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['description'] = this.description;
    return data;
  }
}
