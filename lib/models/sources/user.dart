import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final int id;

  @JsonKey(defaultValue: "")
  final String name;

  @JsonKey(defaultValue: "")
  final String email;

  final bool? isAdmin;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.isAdmin,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    if (other is! User) {
      return false;
    }

    return other.id == id;
  }

  @override
  int get hashCode => id;
}
