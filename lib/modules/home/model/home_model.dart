class MoiveModel {
  String? id;
  String? title;
  String? imageUrl;
  String? genre;
  String? duration;
  String? release;
  String? classification;
  String? location;
  String? hallType;
  String? createdAt;
  String? updatedAt;

  MoiveModel(
      {this.id,
      this.title,
      this.imageUrl,
      this.genre,
      this.duration,
      this.release,
      this.classification,
      this.location,
      this.hallType,
      this.createdAt,
      this.updatedAt});

  MoiveModel.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    title = json['title'].toString();
    imageUrl = json['image_url'].toString();
    genre = json['genre'].toString();
    duration = json['duration'].toString();
    release = json['release'].toString();
    classification = json['classification'].toString();
    location = json['location'].toString();
    hallType = json['hall_type'].toString();
    createdAt = json['created_at'].toString();
    updatedAt = json['updated_at'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id.toString();
    data['title'] = title.toString();
    data['image_url'] = imageUrl.toString();
    data['genre'] = genre.toString();
    data['duration'] = duration.toString();
    data['release'] = release.toString();
    data['classification'] = classification.toString();
    data['location'] = location.toString();
    data['hall_type'] = hallType.toString();
    data['created_at'] = createdAt.toString();
    data['updated_at'] = updatedAt.toString();
    return data;
  }
}
