import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

class LocationResult extends Equatable {
  const LocationResult({
    this.position,
    this.address,
    this.isFromCache = false,
  });
  final Position? position;
  final String? address;
  final bool isFromCache;

  bool get hasLocation => position != null;

  @override
  List<Object?> get props => [position, address, isFromCache];
}
