// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_add_story.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddStoryRequest _$AddStoryRequestFromJson(Map<String, dynamic> json) =>
    AddStoryRequest(
      description: json['description'] as String?,
      photoUrl: json['photoUrl'] as String?,
      lat: (json['lat'] as num?)?.toDouble() ?? 0.0,
      lon: (json['lon'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$AddStoryRequestToJson(AddStoryRequest instance) =>
    <String, dynamic>{
      'description': instance.description,
      'photoUrl': instance.photoUrl,
      'lat': instance.lat,
      'lon': instance.lon,
    };
