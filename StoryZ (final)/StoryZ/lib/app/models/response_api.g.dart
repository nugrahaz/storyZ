// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseApi _$ResponseApiFromJson(Map<String, dynamic> json) => ResponseApi(
      error: json['error'] as bool,
      message: json['message'] as String,
    );

Map<String, dynamic> _$ResponseApiToJson(ResponseApi instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
    };
