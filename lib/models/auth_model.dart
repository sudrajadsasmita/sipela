class AuthModel {
  String? email;
  String? password;
  String? passwordConfirmation;
  String? name;
  String? address;
  String? gender;
  String? dateOfBirth;
  String? whatsapp;

  AuthModel(
    jsonDecode, {
    this.email,
    this.password,
    this.passwordConfirmation,
    this.name,
    this.address,
    this.gender,
    this.dateOfBirth,
    this.whatsapp,
  });

  AuthModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    passwordConfirmation = json['password_confirmation'];
    name = json['name'];
    address = json['address'];
    gender = json['gender'];
    dateOfBirth = json['date_of_birth'];
    whatsapp = json['whatsapp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['password'] = this.password;
    data['password_confirmation'] = this.passwordConfirmation;
    data['name'] = this.name;
    data['address'] = this.address;
    data['gender'] = this.gender;
    data['date_of_birth'] = this.dateOfBirth;
    data['whatsapp'] = this.whatsapp;
    return data;
  }
}
