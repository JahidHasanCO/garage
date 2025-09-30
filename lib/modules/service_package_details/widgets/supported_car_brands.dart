import 'package:flutter/material.dart';
import 'package:garage/data/models/manufacturer.dart';
import 'package:garage/shared/shared.dart';

class SupportedCarBrands extends StatelessWidget {
  const SupportedCarBrands({required this.brands, super.key});

  final List<Manufacturer> brands;

  @override
  Widget build(BuildContext context) {
    if (brands.isEmpty) return const SizedBox.shrink();
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Supported Car Brands',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 80,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: brands.length,
            itemBuilder: (context, index) {
              final manufacturer = brands[index];
              return ManufactureCard(manufacturer: manufacturer);
            },
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
