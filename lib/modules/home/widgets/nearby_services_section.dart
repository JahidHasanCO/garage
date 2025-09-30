import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garage/core/provider/provider.dart';
import 'package:garage/modules/home/widgets/service_package_card.dart';
import 'package:garage/shared/shared.dart';
import 'package:garage/utils/extension/ref.dart';

class NearbyServicesSection extends ConsumerWidget {
  const NearbyServicesSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
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
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  visualDensity: VisualDensity.compact,
                ),
                onPressed: () {},
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
              final status = ref.select(homeProvider, (s) => s.status);
              final packages = ref.select(homeProvider, (s) => s.packages);

              if (status.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (status.isError) return _error();
              if (packages.isEmpty) return _empty();

              // Services horizontal list
              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: packages.length,
                itemBuilder: (context, index) {
                  final package = packages[index];
                  return ServicePackageCard(
                    package: package,
                    onTap: () {},
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _error() {
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
          ProviderSelector(
            provider: homeProvider,
            selector: (value) => value.message,
            builder: (context, message) {
              return Text(
                message,
                style: TextStyle(
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _empty() {
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
}
