import 'package:json_annotation/json_annotation.dart';

part 'creator.g.dart';

@JsonSerializable(explicitToJson: true)
class Creator {
  @JsonKey(name: '_id')
  late String id;
  late String role;
  late String name;

  Creator();

  factory Creator.fromJson(Map<String, dynamic> json) =>
      _$CreatorFromJson(json);

  Map<String, dynamic> toJson() => _$CreatorToJson(this);
}
