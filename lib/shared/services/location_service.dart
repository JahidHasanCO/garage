import 'package:garage/utils/extension/object.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationService {
  static const String _locationKey = 'current_location';
  static const String _addressKey = 'current_address';

  /// Check if location services are enabled
  Future<bool> isLocationServiceEnabled() async {
    return Geolocator.isLocationServiceEnabled();
  }

  /// Check and request location permissions
  Future<LocationPermission> checkPermissions() async {
    var permission = await Geolocator.checkPermission();
    
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    
    return permission;
  }

  /// Get current location
  Future<Position?> getCurrentLocation() async {
    try {
      // Check if location services are enabled
      if (!await isLocationServiceEnabled()) {
        return null;
      }

      // Check permissions
      final permission = await checkPermissions();
      
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        return null;
      }

      // Get current position
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 10,
          timeLimit: Duration(seconds: 10),
        ),
      );

      // Get address from coordinates
      final address = await getAddressFromCoordinates(position);

      // Save both location and address to local storage
      await _saveLocationAndAddressToLocal(position, address);
      
      return position;
    } on LocationServiceDisabledException {
      return null;
    } on PermissionDeniedException {
      return null;
    } on Exception catch (e) {
      e.toString().doPrint(prefix: 'LocationService.getCurrentLocation');
      return null;
    }
  }

  /// Save location and address to SharedPreferences
  Future<void> _saveLocationAndAddressToLocal(Position position, String address) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final locationData = '${position.latitude},${position.longitude}';
      await prefs.setString(_locationKey, locationData);
      await prefs.setString(_addressKey, address);
    } on Exception catch (e) {
      e.toString().doPrint(prefix: 'LocationService._saveLocationAndAddressToLocal');
    }
  }

  /// Get location from local storage
  Future<Position?> getLocationFromLocal() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final locationData = prefs.getString(_locationKey);
      
      if (locationData != null && locationData.isNotEmpty) {
        final parts = locationData.split(',');
        if (parts.length == 2) {
          final latitude = double.tryParse(parts[0]);
          final longitude = double.tryParse(parts[1]);
          
          if (latitude != null && longitude != null) {
            return Position(
              latitude: latitude,
              longitude: longitude,
              timestamp: DateTime.now(),
              accuracy: 0,
              altitude: 0,
              heading: 0,
              speed: 0,
              speedAccuracy: 0,
              altitudeAccuracy: 0,
              headingAccuracy: 0,
            );
          }
        }
      }
      
      return null;
    } on Exception catch (e) {
      e.toString().doPrint(prefix: 'LocationService.getCurrentLocation');
      return null;
    }
  }

  /// Get cached address from local storage
  Future<String?> getCachedAddress() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_addressKey);
    } on Exception catch (e) {
      e.toString().doPrint(prefix: 'LocationService.getCachedAddress');
      return null;
    }
  }
  Future<String> getAddressFromCoordinates(Position position) async {
    try {
      // Get placemarks from coordinates
      final placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      
      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        
        // Build a readable address
        final addressParts = <String>[];
        
        // Add street number and name
        if (place.name != null && place.name!.isNotEmpty) {
          addressParts.add(place.name!);
        }
        
        // Add sublocality (neighborhood)
        if (place.subLocality != null && place.subLocality!.isNotEmpty) {
          addressParts.add(place.subLocality!);
        }
        
        // Add locality (city/town)
        if (place.locality != null && place.locality!.isNotEmpty) {
          addressParts.add(place.locality!);
        }
        
        // Add administrative area (state/province)
        if (place.administrativeArea != null && place.administrativeArea!.isNotEmpty) {
          addressParts.add(place.administrativeArea!);
        }
        
        // Add country
        if (place.country != null && place.country!.isNotEmpty) {
          addressParts.add(place.country!);
        }
        
        // Join address parts with commas
        if (addressParts.isNotEmpty) {
          return addressParts.join(', ');
        }
      }
      
      // Fallback to coordinates if geocoding fails
      return '${position.latitude.toStringAsFixed(4)}, ${position.longitude.toStringAsFixed(4)}';
    } on Exception catch (e) {
      e.toString().doPrint(prefix: 'LocationService.getAddressFromCoordinates');
      // Fallback to coordinates if geocoding fails
      return '${position.latitude.toStringAsFixed(4)}, ${position.longitude.toStringAsFixed(4)}';
    }
  }

  /// Clear saved location and address
  Future<void> clearSavedLocation() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_locationKey);
      await prefs.remove(_addressKey);
    } on Exception catch (e) {
      e.toString().doPrint(prefix: 'LocationService.clearSavedLocation');
    }
  }
}
