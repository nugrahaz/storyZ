import 'package:json_annotation/json_annotation.dart';

part 'registration_model.g.dart';

@JsonSerializable()
class RegistrationModel {
  final String? name;
  final String? email;
  final String? password;

  RegistrationModel({
    this.name,
    this.email,
    this.password,
  });

  factory RegistrationModel.fromJson(Map<String, dynamic> json) =>
      _$RegistrationModelFromJson(json);

  Map<String, dynamic> toJson() => _$RegistrationModelToJson(this);

// factory RegistrationModel.fromJson(Map<String, dynamic> json) =>
//     RegistrationModel(
//       name: json['name'],
//       email: json['email'],
//       password: json['password'],
//     );
//
// Map<String, dynamic> toJson() {
//   return {
//     'name': name,
//     'email': email,
//     'password': password,
//   };
// }
}
