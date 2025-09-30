import 'package:equatable/equatable.dart';

class Location extends Equatable {
  const Location({
    this.type,
    this.coordinates,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    type: json['type'] as String?,
    coordinates: (json['coordinates'] is List)
        ? (json['coordinates'] as List)
              .map((x) => x is num ? x.toDouble() : 0.0)
              .toList()
        : [],
  );

  final String? type;
  final List<double>? coordinates;

  @override
  List<Object?> get props => [
    type,
    coordinates,
  ];
}
