// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_credential.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthCredential _$AuthCredentialFromJson(Map<String, dynamic> json) =>
    AuthCredential(
      json['access_token'] as String,
      json['refresh_token'] as String,
    );

Map<String, dynamic> _$AuthCredentialToJson(AuthCredential instance) =>
    <String, dynamic>{
      'access_token': instance.accessToken,
      'refresh_token': instance.refreshToken,
    };
