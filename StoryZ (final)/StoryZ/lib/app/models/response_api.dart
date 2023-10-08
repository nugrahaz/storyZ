import 'package:json_annotation/json_annotation.dart';

part 'response_api.g.dart';

@JsonSerializable()
class ResponseApi {
  final bool error;
  final String message;

  const ResponseApi({
    required this.error,
    required this.message,
  });

  factory ResponseApi.fromJson(Map<String, dynamic> json) =>
      _$ResponseApiFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseApiToJson(this);

// factory ResponseApi.fromJson(Map<String, dynamic> json) {
//   return ResponseApi(error: json['error'], message: json['message']);
// }
}
