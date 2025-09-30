import 'package:flutter/material.dart';
import 'package:garage/data/models/manufacturer.dart';

class ManufactureCard extends StatelessWidget {
  const ManufactureCard({required this.manufacturer, super.key});

  final Manufacturer manufacturer;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      margin: const EdgeInsets.only(right: 8),
      decoration:  BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              manufacturer.logo ?? '',
              width: 50,
              height: 50,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 50,
                  height: 50,
                  color: Colors.grey[300],
                  child: const Icon(Icons.directions_car, color: Colors.grey),
                );
              },
            ),
          ),
          const SizedBox(height: 4),
          Text(
            manufacturer.name ?? 'Unknown',
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
