// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offers_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OfferModel _$OfferModelFromJson(Map<String, dynamic> json) => OfferModel(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      image: json['image_url'] as String?,
      description: json['description'] as String?,
      rate: (json['rate'] as num?)?.toInt(),
    );

Map<String, dynamic> _$OfferModelToJson(OfferModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'image_url': instance.image,
      'description': instance.description,
      'rate': instance.rate,
    };
