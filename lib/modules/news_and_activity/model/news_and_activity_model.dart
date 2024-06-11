import 'package:json_annotation/json_annotation.dart';

part 'news_and_activity_model.g.dart';

@JsonSerializable()
class NewsAndActivityModel{
  NewsAndActivityModel({
    this.id,
    this.title,
    this.imageUrl,
    this.description
  });

  final int? id;
  final String? title;
  @JsonKey(name: 'image_url')
  final String? imageUrl;
  final String? description;

  factory NewsAndActivityModel.fromJson(Map<String, dynamic> json) =>
      _$NewsAndActivityModelFromJson(json);

  Map<String, dynamic> toJson() => _$NewsAndActivityModelToJson(this);
}
