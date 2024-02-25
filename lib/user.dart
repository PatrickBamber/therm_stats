import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final int id;
  final String name;
  final int age;
  final double temperature;

  User({required this.id, required this.name, required this.age, required this.temperature});

  // fromJson
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  // toJson
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
