import 'package:json_annotation/json_annotation.dart';

part 'f_b_model.g.dart';

@JsonSerializable()
class FBModel{
  FBModel({
    this.id,
    this.title,
    this.imageUrl,
    this.price,
    this.locations,
  });
  
  final int? id;
  final String? title;
  final String? imageUrl;
  final double? price;
  @JsonKey(name: 'location_type')
  final String? locations;

  factory FBModel.fromJson(Map<String, dynamic> json) =>
      _$FBModelFromJson(json);

  Map<String, dynamic> toJson() => _$FBModelToJson(this);
}
