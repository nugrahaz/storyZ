import 'package:json_annotation/json_annotation.dart';

part 'story_model.g.dart';

@JsonSerializable()
class StoryModel {
  final String? id;
  final String? name;
  final String? description;
  final String? photoUrl;
  final DateTime? createdAt;
  final double? lat;
  final double? lon;

  StoryModel({
    this.id,
    this.name,
    this.description,
    this.photoUrl,
    this.createdAt,
    this.lat,
    this.lon,
  });

  factory StoryModel.fromJson(Map<String, dynamic> json) =>
      _$StoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$StoryModelToJson(this);

// factory StoryModel.fromJson(Map<String, dynamic> json) => StoryModel(
//       id: json["id"],
//       name: json["name"],
//       description: json["description"],
//       photoUrl: json["photoUrl"],
//       createdAt: json["createdAt"] == null
//           ? null
//           : DateTime.parse(json["createdAt"]),
//       lat: json["lat"]?.toDouble(),
//       lon: json["lon"]?.toDouble(),
//     );
//
// Map<String, dynamic> toJson() => {
//       "id": id,
//       "name": name,
//       "description": description,
//       "photoUrl": photoUrl,
//       "createdAt": createdAt?.toIso8601String(),
//       "lat": lat,
//       "lon": lon,
//     };
}
