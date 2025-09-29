import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:garage/core/provider/repo.dart';
import 'package:garage/data/enums/state_status.dart';
import 'package:garage/modules/home/providers/service_packages_state.dart';
import 'package:garage/shared/repo/service_package_repo.dart';

class ServicePackagesProvider extends Notifier<ServicePackagesState> {
  late ServicePackageRepo _repo;

  @override
  ServicePackagesState build() {
    _repo = ref.read(servicePackageRepoProvider);
    return const ServicePackagesState();
  }

  /// Get nearby services based on location
  Future<void> getNearbyServices({
    required double lat,
    required double lng,
    int page = 1,
  }) async {
    state = state.copyWith(status: StateStatus.loading);

    try {
      final response = await _repo.getNearbyServices(
        lat: lat,
        lng: lng,
        page: page,
      );

      if (response != null) {
        state = state.copyWith(
          status: StateStatus.success,
          packages: response.packages,
          total: response.total,
          page: response.page,
          pages: response.pages,
          message: 'Services loaded successfully',
        );
      } else {
        state = state.copyWith(
          status: StateStatus.error,
          message: 'Failed to load nearby services',
        );
      }
    } on Exception {
      state = state.copyWith(
        status: StateStatus.error,
        message: 'Failed to load nearby services',
      );
    }
  }

  /// Clear services
  void clearServices() {
    state = const ServicePackagesState();
  }
}

final servicePackagesProvider = NotifierProvider<ServicePackagesProvider, ServicePackagesState>(
  ServicePackagesProvider.new,
);