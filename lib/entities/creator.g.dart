// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creator.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Creator _$CreatorFromJson(Map<String, dynamic> json) => Creator()
  ..id = json['_id'] as String
  ..role = json['role'] as String
  ..name = json['name'] as String;

Map<String, dynamic> _$CreatorToJson(Creator instance) => <String, dynamic>{
      '_id': instance.id,
      'role': instance.role,
      'name': instance.name,
    };
