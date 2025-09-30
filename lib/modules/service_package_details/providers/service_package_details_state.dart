import 'package:equatable/equatable.dart';
import 'package:garage/data/enums/state_status.dart';
import 'package:garage/data/models/service_package.dart';

class ServicePackageDetailsState extends Equatable {
  const ServicePackageDetailsState({
    this.status = StateStatus.initial,
    this.message = '',
    this.package,
  });

  final StateStatus status;
  final String message;
  final ServicePackage? package;

  ServicePackageDetailsState copyWith({
    StateStatus? status,
    String? message,
    ServicePackage? package,
  }) {
    return ServicePackageDetailsState(
      status: status ?? this.status,
      message: message ?? this.message,
      package: package ?? this.package,
    );
  }

  @override
  List<Object?> get props => [status, message, package];
}
