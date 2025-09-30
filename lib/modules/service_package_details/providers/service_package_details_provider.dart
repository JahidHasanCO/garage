import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garage/core/provider/repo.dart';
import 'package:garage/data/enums/state_status.dart';
import 'package:garage/modules/service_package_details/service_package_details.dart';
import 'package:garage/shared/repo/service_package_repo.dart';

class ServicePackageDetailsProvider
    extends Notifier<ServicePackageDetailsState> {
  late ServicePackageRepo _repo;

  @override
  ServicePackageDetailsState build() {
    _repo = ref.read(servicePackageRepoProvider);
    return const ServicePackageDetailsState();
  }

  Future<void> onInit(String id) async {
    await fetchServicePackageDetails(id);
  }

  Future<void> fetchServicePackageDetails(String id) async {
    state = state.copyWith(status: StateStatus.loading, message: '');

    final details = await _repo.retrieveServicePackage(id: id);
    if (details == null) {
      state = state.copyWith(
        status: StateStatus.error,
        message: 'Failed to load service package details',
      );
      return;
    }
    state = state.copyWith(
      status: StateStatus.success,
      package: details,
    );
  }
}
