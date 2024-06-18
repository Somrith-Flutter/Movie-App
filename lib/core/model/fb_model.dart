class FANDBModel {
  String? id;
  String? name;
  String? image;
  String? locationType;
  String? openingHour;
  String? numberHall;
  String? address;

  FANDBModel(
      {this.id,
      this.name,
      this.image,
      this.locationType,
      this.openingHour,
      this.numberHall,
      this.address});

  FANDBModel.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'].toString();
    image = json['image'].toString();
    locationType = json['location_type'].toString();
    openingHour = json['opening_hour'].toString();
    numberHall = json['number_hall'].toString();
    address = json['address'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id.toString();
    data['name'] = name.toString();
    data['image'] = image.toString();
    data['location_type'] = locationType.toString();
    data['opening_hour'] = openingHour.toString();
    data['number_hall'] = numberHall.toString();
    data['address'] = address.toString();
    return data;
  }
}
