import 'package:json_annotation/json_annotation.dart';

part 'news_model.g.dart';

@JsonSerializable()
class NewsModel{
  NewsModel({
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

  factory NewsModel.fromJson(Map<String, dynamic> json) =>
      _$NewsModelFromJson(json);

  Map<String, dynamic> toJson() => _$NewsModelToJson(this);
}
