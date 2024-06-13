import 'package:json_annotation/json_annotation.dart';

part 'offers_model.g.dart';

@JsonSerializable()
class OfferModel{
  OfferModel({
    this.id,
    this.title,
    this.image,
    this.description,
    this.rate,
  });

  final int? id;
  final String? title;
  @JsonKey(name: 'image_url')
  final String? image;
  final String? description;
  final int? rate;

  factory OfferModel.fromJson(Map<String, dynamic> json) =>
      _$OfferModelFromJson(json);

  Map<String, dynamic> toJson() => _$OfferModelToJson(this);
}
