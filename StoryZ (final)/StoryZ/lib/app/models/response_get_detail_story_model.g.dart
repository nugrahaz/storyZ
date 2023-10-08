// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_get_detail_story_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetDetailStoryResult _$GetDetailStoryResultFromJson(
        Map<String, dynamic> json) =>
    GetDetailStoryResult(
      error: json['error'] as bool,
      message: json['message'] as String,
      story: StoryModel.fromJson(json['story'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetDetailStoryResultToJson(
        GetDetailStoryResult instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
      'story': instance.story,
    };
