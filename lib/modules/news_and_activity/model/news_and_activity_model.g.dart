// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_and_activity_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsAndActivityModel _$NewsAndActivityModelFromJson(
        Map<String, dynamic> json) =>
    NewsAndActivityModel(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      imageUrl: json['image_url'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$NewsAndActivityModelToJson(
        NewsAndActivityModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'image_url': instance.imageUrl,
      'description': instance.description,
    };
