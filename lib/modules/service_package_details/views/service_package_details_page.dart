import 'package:flutter/material.dart';
import 'package:garage/modules/service_package_details/service_package_details.dart';
import 'package:garage/routes/router.dart';

class ServicePackageDetailsPage extends StatelessWidget {
  const ServicePackageDetailsPage({required this.id, super.key});

  final String id;

  static final route = GoRoute(
    path: RouteNames.servicePackageDetails.asPath,
    name: RouteNames.servicePackageDetails,
    builder: (context, state) {
      final id = state.uri.queryParameters['id'] ?? '';
      return ServicePackageDetailsPage(id: id);
    },
  );

  @override
  Widget build(BuildContext context) {
    return ServicePackageDetailsView(id: id);
  }
}
