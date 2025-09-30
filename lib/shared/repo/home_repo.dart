import 'package:garage/data/models/location_result.dart';
import 'package:garage/shared/services/location_service.dart';
import 'package:garage/utils/extension/object.dart';
import 'package:geolocator/geolocator.dart';

class HomeRepo {
  final LocationService _locationService = LocationService();

  /// Get current location with fallback to local storage
  Future<LocationResult> getCurrentLocation() async {
    try {
      // First, try to get current location
      final currentPosition = await _locationService.getCurrentLocation();

      if (currentPosition != null) {
        final address = await _locationService.getAddressFromCoordinates(
          currentPosition,
        );
        return LocationResult(
          position: currentPosition,
          address: address,
        );
      }

      // If current location fails, try to get from local storage
      final cachedPosition = await _locationService.getLocationFromLocal();

      if (cachedPosition != null) {
        // Try to get cached address first, fallback to geocoding
        var address = await _locationService.getCachedAddress() ?? '';
        if (address.isEmpty) {
          address = await _locationService.getAddressFromCoordinates(
            cachedPosition,
          );
        }
        return LocationResult(
          position: cachedPosition,
          address: address,
          isFromCache: true,
        );
      }

      // If both fail, return null
      return const LocationResult();
    } on Exception catch (e) {
      e.toString().doPrint(prefix: 'HomeRepo.getCurrentLocation');
      // Try to get cached location as fallback
      final cachedPosition = await _locationService.getLocationFromLocal();

      if (cachedPosition != null) {
        // Try to get cached address first, fallback to geocoding
        var address = await _locationService.getCachedAddress() ?? '';
        if (address.isEmpty) {
          address = await _locationService.getAddressFromCoordinates(
            cachedPosition,
          );
        }
        return LocationResult(
          position: cachedPosition,
          address: address,
          isFromCache: true,
        );
      }

      return const LocationResult();
    }
  }

  /// Check if location services are enabled
  Future<bool> isLocationServiceEnabled() async {
    return _locationService.isLocationServiceEnabled();
  }

  /// Request location permission
  Future<LocationPermission> requestLocationPermission() async {
    return _locationService.checkPermissions();
  }

  /// Clear saved location
  Future<void> clearSavedLocation() async {
    await _locationService.clearSavedLocation();
  }
}
