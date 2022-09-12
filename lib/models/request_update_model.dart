class RequestUpdateModel {
  String? requestId;
  String? name;
  String? barangbaseId;
  String? requestFrom;
  String? requestStatus;
  String? imgUrl;

  RequestUpdateModel({
    this.requestId,
    this.name,
    this.barangbaseId,
    this.requestFrom,
    this.requestStatus,
    this.imgUrl,
  });

  RequestUpdateModel.fromJson(Map<String, dynamic> json) {
    requestId = json['request_id'];
    name = json['name'];
    barangbaseId = json['barangbase_id'];
    requestFrom = json['request_from'];
    requestStatus = json['request_status'];
    imgUrl = json['img_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['request_id'] = this.requestId;
    data['name'] = this.name;
    data['barangbase_id'] = this.barangbaseId;
    data['request_from'] = this.requestFrom;
    data['request_status'] = this.requestStatus;
    data['img_url'] = this.imgUrl;
    return data;
  }
}
