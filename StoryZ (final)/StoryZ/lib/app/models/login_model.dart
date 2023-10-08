import 'package:json_annotation/json_annotation.dart';

part 'login_model.g.dart';

@JsonSerializable()
class LoginModel {
  final String? email;
  final String? password;

  LoginModel({
    this.email,
    this.password,
  });

  LoginModel copyWith({
    String? email,
    String? password,
  }) =>
      LoginModel(
        email: email ?? this.email,
        password: password ?? this.password,
      );

  factory LoginModel.fromJson(Map<String, dynamic> json) =>
      _$LoginModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginModelToJson(this);

// factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
//       email: json["email"],
//       password: json["password"],
//     );
//
// Map<String, dynamic> toJson() => {
//       "email": email,
//       "password": password,
//     };
}
