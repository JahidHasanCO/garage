import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garage/core/provider/provider.dart';
import 'package:garage/shared/shared.dart';
import 'package:garage/utils/extension/ref.dart';

class NearbyGaragesSection extends ConsumerWidget {
  const NearbyGaragesSection({super.key});

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
                'Nearby Garages',
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
          height: 150,
          child: Builder(
            builder: (context) {
              final status = ref.select(homeProvider, (s) => s.status);
              final garages = ref.select(homeProvider, (s) => s.garages);

              if (status.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (status.isError) return _error();
              if (garages.isEmpty) return _empty();

              // Services horizontal list
              return ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: garages.length,
                itemBuilder: (context, index) {
                  final garage = garages[index];
                  return GarageCard(garage: garage);
                },
                separatorBuilder: (context, index) => const SizedBox(width: 12),
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
            Icons.garage,
            size: 48,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 8),
          Text(
            'No nearby garages found',
            style: TextStyle(
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
