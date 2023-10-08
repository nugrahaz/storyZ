import 'package:json_annotation/json_annotation.dart';
import 'package:storyz/app/models/story_model.dart';

part 'response_get_detail_story_model.g.dart';

@JsonSerializable()
class GetDetailStoryResult {
  final bool error;
  final String message;
  final StoryModel story;

  GetDetailStoryResult({
    required this.error,
    required this.message,
    required this.story,
  });

  factory GetDetailStoryResult.fromJson(Map<String, dynamic> json) =>
      _$GetDetailStoryResultFromJson(json);

  Map<String, dynamic> toJson() => _$GetDetailStoryResultToJson(this);
// factory GetDetailStoryResult.fromJson(Map<String, dynamic> json) =>
//     GetDetailStoryResult(
//       error: json['error'],
//       message: json['message'],
//       storyModel: StoryModel.fromJson(json['story']),
//     );
}
