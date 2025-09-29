import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garage/modules/home/providers/service_packages_provider.dart';
import 'package:garage/modules/home/views/service_package_details_page.dart';
import 'package:garage/modules/home/widgets/service_package_card.dart';

class NearbyServicesSection extends ConsumerWidget {
  const NearbyServicesSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final servicePackagesState = ref.watch(servicePackagesProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Nearby Services',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {
                  // TODO: Handle see all tap
                },
                child: const Text('See All'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        // Services list
        SizedBox(
          height: 300,
          child: Builder(
            builder: (context) {
              if (servicePackagesState.status.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (servicePackagesState.status.isError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: 48,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        servicePackagesState.message,
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              }

              if (!servicePackagesState.hasPackages) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.local_car_wash_outlined,
                        size: 48,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'No nearby services found',
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                );
              }

              // Services horizontal list
              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: servicePackagesState.packages.length,
                itemBuilder: (context, index) {
                  final package = servicePackagesState.packages[index];
                  return ServicePackageCard(
                    package: package,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (context) => ServicePackageDetailsPage(
                            package: package,
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}