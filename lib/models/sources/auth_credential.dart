import 'package:json_annotation/json_annotation.dart';

part 'auth_credential.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class AuthCredential {
  final String accessToken;
  final String refreshToken;

  AuthCredential(this.accessToken, this.refreshToken);

  static AuthCredential fromJson(Map<String, dynamic> json) =>
      _$AuthCredentialFromJson(json);

  Map<String, dynamic> toJson() => _$AuthCredentialToJson(this);
}
