import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garage/modules/home/providers/home_provider.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          // Location display with refresh button
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  homeState.isLocationFromCache 
                      ? Icons.location_off 
                      : Icons.location_on,
                  size: 16,
                  color: homeState.isLocationFromCache 
                      ? Colors.orange 
                      : Colors.green,
                ),
                const SizedBox(width: 4),
                Container(
                  constraints: const BoxConstraints(maxWidth: 150),
                  child: Text(
                    _getShortLocationText(homeState.displayLocation),
                    style: Theme.of(context).textTheme.bodySmall,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: homeState.status.isLoading 
                      ? null 
                      : () => ref.read(homeProvider.notifier).refreshLocation(),
                  child: homeState.status.isLoading
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        )
                      : const Icon(
                          Icons.refresh,
                          size: 16,
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Location status card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          homeState.hasLocation 
                              ? Icons.location_on 
                              : Icons.location_off,
                          color: homeState.hasLocation 
                              ? Colors.green 
                              : Colors.red,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Location Status',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    if (homeState.hasLocation) ...[
                      Text(
                        'Address: ${homeState.displayLocation}',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      if (homeState.currentLocation != null) ...[
                        Text(
                          'Coordinates: ${homeState.currentLocation!.latitude.toStringAsFixed(6)}, ${homeState.currentLocation!.longitude.toStringAsFixed(6)}',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 4),
                      ],
                      Text(
                        homeState.isLocationFromCache 
                            ? 'Source: Cached (Location service may be off)'
                            : 'Source: Current location',
                        style: TextStyle(
                          color: homeState.isLocationFromCache 
                              ? Colors.orange 
                              : Colors.green,
                          fontSize: 12,
                        ),
                      ),
                    ] else ...[
                      const Text('Location not available'),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: homeState.status.isLoading 
                            ? null 
                            : () => ref.read(homeProvider.notifier).refreshLocation(),
                        child: homeState.status.isLoading
                            ? const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: CircularProgressIndicator(strokeWidth: 2),
                                  ),
                                  SizedBox(width: 8),
                                  Text('Getting location...'),
                                ],
                              )
                            : const Text('Get Location'),
                      ),
                    ],
                    if (homeState.message.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Text(
                        homeState.message,
                        style: TextStyle(
                          color: homeState.status.isError 
                              ? Colors.red 
                              : Colors.blue,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Other home content can go here
            const Expanded(
              child: Center(
                child: Text('Welcome to Home!'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Helper method to get a short version of location text for AppBar
  String _getShortLocationText(String fullLocation) {
    // If it's an address, try to show just the city/area
    if (fullLocation.contains(',')) {
      final parts = fullLocation.split(',');
      if (parts.length >= 2) {
        // Show first two parts (usually street + area/city)
        return '${parts[0].trim()}, ${parts[1].trim()}';
      }
    }
    return fullLocation;
  }
}