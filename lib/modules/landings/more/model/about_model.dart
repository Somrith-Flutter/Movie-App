import 'package:json_annotation/json_annotation.dart';

part 'about_model.g.dart';

@JsonSerializable()
class AboutModel{
  AboutModel({
    this.id,
    this.title,
    this.image,
    this.description,
    this.subtitle,
  });

  final int? id;
  final String? title;
  final String? image;
  final String? description;
  final String? subtitle;
  
  factory AboutModel.fromJson(Map<String, dynamic> json) =>
      _$AboutModelFromJson(json);

  Map<String, dynamic> toJson() => _$AboutModelToJson(this);
}
