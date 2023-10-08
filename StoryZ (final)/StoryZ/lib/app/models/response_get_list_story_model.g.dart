// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_get_list_story_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseGetListStory _$ResponseGetListStoryFromJson(
        Map<String, dynamic> json) =>
    ResponseGetListStory(
      error: json['error'] as bool?,
      message: json['message'] as String?,
      listStory: (json['listStory'] as List<dynamic>?)
          ?.map((e) => StoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ResponseGetListStoryToJson(
        ResponseGetListStory instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
      'listStory': instance.listStory,
    };
