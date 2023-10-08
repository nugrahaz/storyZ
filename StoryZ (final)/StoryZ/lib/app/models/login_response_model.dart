import 'package:json_annotation/json_annotation.dart';
import 'package:storyz/app/models/login_result_model.dart';

part 'login_response_model.g.dart';

@JsonSerializable()
class LoginResponseModel {
  final bool? error;
  final String? message;
  final LoginResult? loginResult;

  LoginResponseModel({
    this.error,
    this.message,
    this.loginResult,
  });

  LoginResponseModel copyWith({
    bool? error,
    String? message,
    LoginResult? loginResult,
  }) =>
      LoginResponseModel(
        error: error ?? this.error,
        message: message ?? this.message,
        loginResult: loginResult ?? this.loginResult,
      );

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseModelToJson(this);

// factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
//     LoginResponseModel(
//       error: json["error"],
//       message: json["message"],
//       loginResult: json["loginResult"] == null
//           ? null
//           : LoginResult.fromJson(json["loginResult"]),
//     );
//
// Map<String, dynamic> toJson() => {
//       "error": error,
//       "message": message,
//       "loginResult": loginResult?.toJson(),
//     };
}
