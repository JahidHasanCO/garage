import 'package:flutter/material.dart';
import 'package:garage/data/models/service_package.dart';

class ServicePackageCard extends StatelessWidget {
  const ServicePackageCard({
    required this.package,
    required this.onTap,
    super.key,
  });

  final ServicePackage package;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 280,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              offset: const Offset(0, 2),
              blurRadius: 8,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Service package image
            Container(
              height: 160,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                image: package.image != null
                    ? DecorationImage(
                        image: NetworkImage(package.image!),
                        fit: BoxFit.cover,
                        onError: (exception, stackTrace) {
                          // Handle image loading error
                        },
                      )
                    : null,
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.3),
                    ],
                  ),
                ),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        '৳${package.price?.toStringAsFixed(0)}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // Package details
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Package name
                  Text(
                    package.name ?? 'Unnamed Package',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  // Services count
                  Text(
                    '${package.services?.length} services included',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Garage info
                  if (package.garages?.isNotEmpty ?? false) ...[
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 14,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            package.garages!.first.name ?? 'Unnamed Garage',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  color: Colors.grey[600],
                                ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                  ],
                  // Duration info
                  if ((package.duration ?? 0) > 0) ...[
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 14,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${package.duration} minutes',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: Colors.grey[600],
                              ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
