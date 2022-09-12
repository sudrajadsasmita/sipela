class UserManagementUpdateModel {
  String? userId;
  String? email;
  String? role;

  UserManagementUpdateModel({
    this.userId,
    this.email,
    this.role,
  });

  UserManagementUpdateModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    email = json['email'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['email'] = this.email;
    data['role'] = this.role;
    return data;
  }
}
