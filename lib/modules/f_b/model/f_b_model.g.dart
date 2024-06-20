// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'f_b_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FBModel _$FBModelFromJson(Map<String, dynamic> json) => FBModel(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      imageUrl: json['imageUrl'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      locations: json['location_type'] as String?,
    );

Map<String, dynamic> _$FBModelToJson(FBModel instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'imageUrl': instance.imageUrl,
      'price': instance.price,
      'location_type': instance.locations,
    };
