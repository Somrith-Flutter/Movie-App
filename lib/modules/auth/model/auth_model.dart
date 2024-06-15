class UserModel {
  String? id;
  String? name;
  String? imageProfile;
  String? email;
  String? phone;
  String? gender;
  String? dateOfBirth;
  String? emailVerifiedAt;
  String? createdAt;
  String? updatedAt;

  UserModel(
      {this.id,
      this.name,
      this.imageProfile,
      this.email,
      this.phone,
      this.gender,
      this.dateOfBirth,
      this.emailVerifiedAt,
      this.createdAt,
      this.updatedAt});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'].toString();
    imageProfile = json['image_profile'].toString();
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
    data['image_profile'] = imageProfile.toString();
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
