class FBFromServiceModel {
  String? id;
  String? title;
  String? imageUrl;
  double? price;
  String? locationType;
  String? createdAt;
  String? updatedAt;

  FBFromServiceModel(
      {this.id,
      this.title,
      this.imageUrl,
      this.price,
      this.locationType,
      this.createdAt,
      this.updatedAt});

  FBFromServiceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    title = json['title'].toString();
    imageUrl = json['image_url'].toString();
    price = json['price'];
    locationType = json['location_type'].toString();
    createdAt = json['created_at'].toString();
    updatedAt = json['updated_at'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id.toString();
    data['title'] = title.toString();
    data['image_url'] = imageUrl.toString();
    data['price'] = price.toString();
    data['location_type'] = locationType.toString();
    data['created_at'] = createdAt.toString();
    data['updated_at'] = updatedAt.toString();
    return data;
  }
}
