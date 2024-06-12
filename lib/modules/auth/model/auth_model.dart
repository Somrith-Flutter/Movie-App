// import 'dart:js_interop';

class AuthModel {
  String? id;
  String? name;
  String? email;
  String? phone;
  String? gender;
  String? dateOfBirth;
  String? emailVerifiedAt;
  String? createdAt;
  String? updatedAt;

  AuthModel(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.gender,
      this.dateOfBirth,
      this.emailVerifiedAt,
      this.createdAt,
      this.updatedAt});

  AuthModel.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'].toString();
    email = json['email'].toString();
    phone = json['phone'].toString();
    gender = json['gender'].toString();
    dateOfBirth = json['date_of_birth'].toString();
    emailVerifiedAt = json['email_verified_at'].toString();
    createdAt = json['created_at'].toString();
    updatedAt = json['updated_at'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id.toString();
    data['name'] = name.toString();
    data['email'] = email.toString();
    data['phone'] = phone.toString();
    data['gender'] = gender.toString();
    data['date_of_birth'] = dateOfBirth.toString();
    data['email_verified_at'] = emailVerifiedAt.toString();
    data['created_at'] = createdAt.toString();
    data['updated_at'] = updatedAt.toString();
    return data;
  }
}
