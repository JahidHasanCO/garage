import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:garage/data/models/fuel_type.dart';

class SupportedFuelTypes extends StatelessWidget {
  const SupportedFuelTypes({required this.fuelTypes, super.key});

  final List<FuelType> fuelTypes;

  @override
  Widget build(BuildContext context) {
    if (fuelTypes.isEmpty) return const SizedBox.shrink();
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Supported Fuel Types',
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: fuelTypes.map((fuelType) {
            return Chip(
              avatar: fuelType.image != null
                  ? CachedNetworkImage(
                      imageUrl: fuelType.image!,
                      cacheKey: fuelType.id,
                      width: 24,
                      height: 24,
                      errorWidget: (context, error, stackTrace) {
                        return const Icon(Icons.local_gas_station);
                      },
                    )
                  : const Icon(Icons.local_gas_station),
              label: Text(fuelType.title ?? 'Unknown'),
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                  width: 0,
                  color: Colors.transparent,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
