import 'package:json_annotation/json_annotation.dart';

part 'request_add_story.g.dart';

@JsonSerializable()
class AddStoryRequest {
  final String? description;
  final String? photoUrl;
  final double? lat;
  final double? lon;

  AddStoryRequest({
    this.description,
    this.photoUrl,
    this.lat = 0.0,
    this.lon = 0.0,
  });

  factory AddStoryRequest.fromJson(Map<String, dynamic> json) =>
      _$AddStoryRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddStoryRequestToJson(this);
}

//// GENERATED CODE - DO NOT MODIFY BY HAND
//
// part of 'request_add_story.dart';
//
// // **************************************************************************
// // JsonSerializableGenerator
// // **************************************************************************
//
// AddStoryRequest _AddStoryRequestFromJson(Map<String, dynamic> json) =>
//     AddStoryRequest(
//       description: json['description'] as String,
//       photo: json['photo'] as File,
//       lat: json['lat'] as double,
//       lon: json['lon'] as double,
//     );
//
// Map<String, dynamic> _$AddStoryRequestToJson(AddStoryRequest instance) =>
//     <String, dynamic>{
//       'description': instance.description,
//       'photo': instance.photo,
//       'lat': instance.lat,
//       'lon': instance.lon,
//     };
