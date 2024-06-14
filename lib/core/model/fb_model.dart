class FANDBModel {
  String? id;
  String? name;
  String? image;
  String? locationType;

  FANDBModel({this.id, this.name, this.image});

  FANDBModel.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'].toString();
    image = json['image'].toString();
    locationType = json['location_type'].toString();
  }

  Map<String, dynamic> toJson() {
    // ignore: prefer_collection_literals
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id.toString();
    data['name'] = name.toString();
    data['image'] = image.toString();
    data['location_type'] = image.toString();
    return data;
  }
}
