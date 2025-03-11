import 'dart:convert';

import 'package:equatable/equatable.dart';

/// {@template coffee}
/// Model representing the coffee data.
/// {@endtemplate}
final class Coffee extends Equatable {
  /// {@macro coffee}
  const Coffee({this.file = ''});

  /// Factory constructor that accepts a [Map<String, dynamic>] as a parameter.
  /// Returns a [Coffee] instance.
  factory Coffee.fromMap(Map<String, dynamic>? json) {
    if (json == null) return const Coffee();
    return Coffee(file: json['file'] as String? ?? '');
  }

  /// Converts a [Map<String, dynamic>] or a [String] to a [Coffee].
  factory Coffee.fromJson(dynamic data) {
    if (data == null) return const Coffee();
    if (data is String) {
      return Coffee.fromMap(json.decode(data) as Map<String, dynamic>);
    }
    if (data is Map<String, dynamic>) return Coffee.fromMap(data);
    return const Coffee();
  }

  /// Converts a [List<dynamic>] to a list of [Coffee].
  /// Returns an empty list if [data] is `null`.
  static List<Coffee> fromJsonList(dynamic data) {
    if (data == null) return <Coffee>[];
    if (data is String) {
      return List<Coffee>.from(
        (json.decode(data) as Iterable<dynamic>).map(Coffee.fromJson),
      );
    }
    if (data is List<dynamic>) {
      return List<Coffee>.from(data.map(Coffee.fromJson));
    }
    return <Coffee>[];
  }

  /// Contains an URL from which load the coffee image.
  final String file;

  /// Returns a [String] representation of the [Coffee].
  String get toJson => json.encode(toMap);

  /// Replicate this [Coffee] with some changes.
  Coffee copyWith({String? file}) => Coffee(file: file ?? this.file);

  /// Converts this [Coffee] to a [Map<String, dynamic>].
  Map<String, dynamic> get toMap => {'file': file};

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [file];
}
