import 'package:equatable/equatable.dart';
import 'package:garage/data/enums/state_status.dart';
import 'package:garage/data/models/garage.dart';
import 'package:garage/data/models/service_package.dart';
import 'package:geolocator/geolocator.dart';

class HomeState extends Equatable {
  const HomeState({
    this.status = StateStatus.initial,
    this.message = '',
    this.currentLocation,
    this.locationAddress,
    this.isLocationFromCache = false,
    this.hasLocationPermission = false,
    this.isLocationServiceEnabled = false,
    this.packages = const [],
    this.garages = const [],
  });

  final StateStatus status;
  final String message;
  final Position? currentLocation;
  final String? locationAddress;
  final bool isLocationFromCache;
  final bool hasLocationPermission;
  final bool isLocationServiceEnabled;
  final List<ServicePackage> packages;
  final List<Garage> garages;

  HomeState copyWith({
    StateStatus? status,
    String? message,
    Position? currentLocation,
    String? locationAddress,
    bool? isLocationFromCache,
    bool? hasLocationPermission,
    bool? isLocationServiceEnabled,
    List<ServicePackage>? packages,
    List<Garage>? garages,
  }) {
    return HomeState(
      status: status ?? this.status,
      message: message ?? this.message,
      currentLocation: currentLocation ?? this.currentLocation,
      locationAddress: locationAddress ?? this.locationAddress,
      isLocationFromCache: isLocationFromCache ?? this.isLocationFromCache,
      hasLocationPermission:
          hasLocationPermission ?? this.hasLocationPermission,
      isLocationServiceEnabled:
          isLocationServiceEnabled ?? this.isLocationServiceEnabled,
      packages: packages ?? this.packages,
      garages: garages ?? this.garages,
    );
  }

  bool get hasLocation => currentLocation != null;

  String get displayLocation {
    if (locationAddress != null && locationAddress!.isNotEmpty) {
      return locationAddress!;
    }
    if (currentLocation != null) {
      return '${currentLocation!.latitude.toStringAsFixed(4)},'
          ' ${currentLocation!.longitude.toStringAsFixed(4)}';
    }
    return 'Location not available';
  }

  @override
  List<Object?> get props => [
    status,
    message,
    currentLocation,
    locationAddress,
    isLocationFromCache,
    hasLocationPermission,
    isLocationServiceEnabled,
    packages,
    garages,
  ];
}
