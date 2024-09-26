// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'open_graph_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OpenGraphModel _$OpenGraphModelFromJson(Map<String, dynamic> json) =>
    OpenGraphModel(
      duration: json['duration'] as String?,
      title: json['title'] as String?,
      type: json['type'] as String?,
      originalUrl: json['originalUrl'] as String?,
      url: json['url'] as String?,
      siteName: json['siteName'] as String?,
      description: json['description'] as String?,
      favicon: json['favicon'] as String?,
      locale: json['locale'] as String?,
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => OpenGraphImageModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OpenGraphModelToJson(OpenGraphModel instance) =>
    <String, dynamic>{
      'duration': instance.duration,
      'title': instance.title,
      'type': instance.type,
      'originalUrl': instance.originalUrl,
      'url': instance.url,
      'siteName': instance.siteName,
      'description': instance.description,
      'favicon': instance.favicon,
      'locale': instance.locale,
      'images': instance.images,
    };

OpenGraphImageModel _$OpenGraphImageModelFromJson(Map<String, dynamic> json) =>
    OpenGraphImageModel(
      image: json['image'] as String?,
      width: (json['width'] as num?)?.toInt(),
    );

Map<String, dynamic> _$OpenGraphImageModelToJson(
        OpenGraphImageModel instance) =>
    <String, dynamic>{
      'image': instance.image,
      'width': instance.width,
    };
