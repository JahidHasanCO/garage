import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garage/core/provider/repo.dart';
import 'package:garage/data/enums/state_status.dart';
import 'package:garage/modules/home/providers/home_state.dart';
import 'package:garage/shared/repo/home_repo.dart';
import 'package:geolocator/geolocator.dart';

class HomeProvider extends Notifier<HomeState> {
  late HomeRepo _repo;

  @override
  HomeState build() {
    _repo = ref.read(homeRepoProvider);
    // Initialize location on build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initializeLocation();
    });
    return const HomeState();
  }

  /// Initialize location on app start
  Future<void> initializeLocation() async {
    state = state.copyWith(status: StateStatus.loading);
    
    try {
      // Check if location service is enabled
      final isServiceEnabled = await _repo.isLocationServiceEnabled();
      
      if (!isServiceEnabled) {
        // Try to get cached location
        final result = await _repo.getCurrentLocation();
        state = state.copyWith(
          status: StateStatus.success,
          currentLocation: result.position,
          locationAddress: result.address,
          isLocationFromCache: result.isFromCache,
          isLocationServiceEnabled: false,
          message: result.hasLocation 
              ? 'Using cached location' 
              : 'Location service is disabled',
        );
        return;
      }

      // Check permissions
      final permission = await _repo.requestLocationPermission();
      
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        // Try to get cached location
        final result = await _repo.getCurrentLocation();
        state = state.copyWith(
          status: StateStatus.success,
          currentLocation: result.position,
          locationAddress: result.address,
          isLocationFromCache: result.isFromCache,
          hasLocationPermission: false,
          isLocationServiceEnabled: isServiceEnabled,
          message: result.hasLocation 
              ? 'Using cached location' 
              : 'Location permission denied',
        );
        return;
      }

      // Get current location
      final result = await _repo.getCurrentLocation();
      
      state = state.copyWith(
        status: StateStatus.success,
        currentLocation: result.position,
        locationAddress: result.address,
        isLocationFromCache: result.isFromCache,
        hasLocationPermission: true,
        isLocationServiceEnabled: isServiceEnabled,
        message: result.isFromCache 
            ? 'Using cached location' 
            : 'Location updated',
      );
      
    } on Exception {
      // Try to get cached location as fallback
      final result = await _repo.getCurrentLocation();
      state = state.copyWith(
        status: StateStatus.error,
        currentLocation: result.position,
        locationAddress: result.address,
        isLocationFromCache: result.isFromCache,
        message: result.hasLocation 
            ? 'Using cached location' 
            : 'Failed to get location',
      );
    }
  }

  /// Refresh current location
  Future<void> refreshLocation() async {
    state = state.copyWith(status: StateStatus.loading);
    
    try {
      final result = await _repo.getCurrentLocation();
      
      state = state.copyWith(
        status: StateStatus.success,
        currentLocation: result.position,
        locationAddress: result.address,
        isLocationFromCache: result.isFromCache,
        message: result.isFromCache 
            ? 'Using cached location' 
            : 'Location updated',
      );
      
    } on Exception {
      state = state.copyWith(
        status: StateStatus.error,
        message: 'Failed to refresh location',
      );
    }
  }

  /// Clear saved location
  Future<void> clearLocation() async {
    await _repo.clearSavedLocation();
    state = state.copyWith(
      currentLocation: null,
      locationAddress: null,
      isLocationFromCache: false,
      message: 'Location cleared',
    );
  }
}

final homeProvider = NotifierProvider<HomeProvider, HomeState>(
  HomeProvider.new,
);