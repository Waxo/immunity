import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'person.g.dart';

@JsonSerializable(explicitToJson: true)
class Person {
  @JsonKey(name: '_id')
  final String id;
  final bool isIll;
  final int recoveryTime;

  Person({
    required this.id,
    required this.isIll,
    required this.recoveryTime,
  });

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);

  Color? get color => switch (recoveryTime) {
        1 => Colors.green,
        2 => Colors.orange,
        3 => Colors.red,
        _ => null,
      };
}
