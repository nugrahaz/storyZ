import 'package:json_annotation/json_annotation.dart';
import 'package:storyz/app/models/story_model.dart';

part 'response_get_list_story_model.g.dart';

@JsonSerializable()
class ResponseGetListStory {
  final bool? error;
  final String? message;
  final List<StoryModel>? listStory;

  ResponseGetListStory({
    this.error,
    this.message,
    this.listStory,
  });

  factory ResponseGetListStory.fromJson(Map<String, dynamic> json) =>
      _$ResponseGetListStoryFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseGetListStoryToJson(this);

// factory ResponseGetListStory.fromJson(Map<String, dynamic> json) =>
//     ResponseGetListStory(
//       error: json["error"],
//       message: json["message"],
//       listStory: json["listStory"] == null
//           ? []
//           : List<StoryModel>.from(
//               json["listStory"]!.map((x) => StoryModel.fromJson(x))),
//     );
//
// Map<String, dynamic> toJson() => {
//       "error": error,
//       "message": message,
//       "listStory": listStory == null
//           ? []
//           : List<dynamic>.from(listStory!.map((x) => x.toJson())),
//     };
}

// ResponseGetListStory responseGetStoryFromJson(String str) =>
//     ResponseGetListStory.fromJson(json.decode(str));
//
// String responseGetStoryToJson(ResponseGetListStory data) =>
//     json.encode(data.toJson());
