import 'package:json_annotation/json_annotation.dart';

part 'login_result_model.g.dart';

@JsonSerializable()
class LoginResult {
  final String? userId;
  final String? name;
  final String? token;

  LoginResult({
    this.userId,
    this.name,
    this.token,
  });

  LoginResult copyWith({
    String? userId,
    String? name,
    String? token,
  }) =>
      LoginResult(
        userId: userId ?? this.userId,
        name: name ?? this.name,
        token: token ?? this.token,
      );

  factory LoginResult.fromJson(Map<String, dynamic> json) =>
      _$LoginResultFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResultToJson(this);

// factory LoginResult.fromJson(Map<String, dynamic> json) => LoginResult(
//       userId: json["userId"],
//       name: json["name"],
//       token: json["token"],
//     );
//
// Map<String, dynamic> toJson() => {
//       "userId": userId,
//       "name": name,
//       "token": token,
//     };
}
