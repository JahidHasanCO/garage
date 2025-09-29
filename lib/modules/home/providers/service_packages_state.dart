import 'package:equatable/equatable.dart';
import 'package:garage/data/enums/state_status.dart';
import 'package:garage/data/models/service_package.dart';

class ServicePackagesState extends Equatable {
  const ServicePackagesState({
    this.status = StateStatus.initial,
    this.message = '',
    this.packages = const [],
    this.total = 0,
    this.page = 1,
    this.pages = 0,
  });

  final StateStatus status;
  final String message;
  final List<ServicePackage> packages;
  final int total;
  final int page;
  final int pages;

  ServicePackagesState copyWith({
    StateStatus? status,
    String? message,
    List<ServicePackage>? packages,
    int? total,
    int? page,
    int? pages,
  }) {
    return ServicePackagesState(
      status: status ?? this.status,
      message: message ?? this.message,
      packages: packages ?? this.packages,
      total: total ?? this.total,
      page: page ?? this.page,
      pages: pages ?? this.pages,
    );
  }

  bool get hasPackages => packages.isNotEmpty;

  @override
  List<Object?> get props => [
        status,
        message,
        packages,
        total,
        page,
        pages,
      ];
}