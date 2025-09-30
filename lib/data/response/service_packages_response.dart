import 'package:garage/data/models/service_package.dart';

class ServicePackagesResponse {
  ServicePackagesResponse({
    this.packages,
    this.total,
    this.page,
    this.pages,
  });

  factory ServicePackagesResponse.fromJson(Map<String, dynamic> json) =>
      ServicePackagesResponse(
        packages: json['packages'] == null
            ? []
            : List<ServicePackage>.from(
                (json['packages'] as List<dynamic>).map(
                  (x) => ServicePackage.fromJson(x as Map<String, dynamic>),
                ),
              ),
        total: json['total'] is int
            ? json['total'] as int
            : int.tryParse(json['total']?.toString() ?? ''),
        page: json['page'] is int
            ? json['page'] as int
            : int.tryParse(json['page']?.toString() ?? ''),
        pages: json['pages'] is int
            ? json['pages'] as int
            : int.tryParse(json['pages']?.toString() ?? ''),
      );

  final List<ServicePackage>? packages;
  final int? total;
  final int? page;
  final int? pages;
}
