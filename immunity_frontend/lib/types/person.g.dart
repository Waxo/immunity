// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Person _$PersonFromJson(Map<String, dynamic> json) => Person(
      id: json['_id'] as String,
      isIll: json['isIll'] as bool,
      recoveryTime: json['recoveryTime'] as int,
    );

Map<String, dynamic> _$PersonToJson(Person instance) => <String, dynamic>{
      '_id': instance.id,
      'isIll': instance.isIll,
      'recoveryTime': instance.recoveryTime,
    };
