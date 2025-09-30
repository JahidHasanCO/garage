import 'package:equatable/equatable.dart';

class Geo extends Equatable {
  const Geo({
    this.lat,
    this.lng,
  });

  factory Geo.fromJson(Map<String, dynamic> json) => Geo(
    lat: (json['lat'] is num) ? (json['lat'] as num).toDouble() : null,
    lng: (json['lng'] is num) ? (json['lng'] as num).toDouble() : null,
  );
  final double? lat;
  final double? lng;

  @override
  List<Object?> get props => [
    lat,
    lng,
  ];
}
