import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garage/core/provider/provider.dart';
import 'package:garage/data/models/garage.dart';
import 'package:garage/data/models/manufacturer.dart';
import 'package:garage/data/models/service.dart';

class ServicePackageDetailsView extends ConsumerStatefulWidget {
  const ServicePackageDetailsView({required this.id, super.key});

  final String id;

  @override
  ServicePackageDetailsViewState createState() =>
      ServicePackageDetailsViewState();
}

class ServicePackageDetailsViewState
    extends ConsumerState<ServicePackageDetailsView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(servicePackageDetailsProvider.notifier).onInit(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(servicePackageDetailsProvider);
    return Scaffold(
      body: state.status.isLoading
          ? _loading()
          : state.status.isError
          ? _error(state.message)
          : CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 250,
                  pinned: true,
                  flexibleSpace: state.package?.image != null
                      ? FlexibleSpaceBar(
                          background: Image.network(
                            state.package!.image!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey[300],
                                child: const Icon(
                                  Icons.car_repair,
                                  size: 64,
                                  color: Colors.grey,
                                ),
                              );
                            },
                          ),
                        )
                      : null,
                ),
                // Content
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Package name and price
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                state.package?.name ?? 'Service Package',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                '৳${state.package?.price?.toStringAsFixed(0)}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Description
                        Text(
                          'Description',
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          state.package?.description ??
                              'No description available.',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 24),

                        // Services included
                        Text(
                          'Services Included (${state.package?.services?.length})',
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        const SizedBox(height: 12),
                        ...state.package?.services?.map(
                              (service) => _buildServiceItem(context, service),
                            ) ??
                            [],
                        const SizedBox(height: 24),

                        // Garage information
                        if (state.package?.garages?.isNotEmpty ?? false) ...[
                          Text(
                            'Service Provider',
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          const SizedBox(height: 12),
                          _buildGarageCard(
                            context,
                            state.package!.garages!.first,
                          ),
                          const SizedBox(height: 24),
                        ],

                        // Applicable manufacturers
                        if (state
                                .package
                                ?.applicableManufacturers
                                ?.isNotEmpty ??
                            false) ...[
                          Text(
                            'Supported Car Brands',
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            height: 80,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  state
                                      .package
                                      ?.applicableManufacturers
                                      ?.length ??
                                  0,
                              itemBuilder: (context, index) {
                                final manufacturer = state
                                    .package
                                    ?.applicableManufacturers![index];
                                return _buildManufacturerItem(
                                  context,
                                  manufacturer!,
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 24),
                        ],

                        // Fuel types
                        if (state.package?.applicableFuelTypes?.isNotEmpty ??
                            false) ...[
                          Text(
                            'Supported Fuel Types',
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children:
                                state.package?.applicableFuelTypes?.map((
                                  fuelType,
                                ) {
                                  return Chip(
                                    label: Text(fuelType.title ?? 'Unknown'),
                                    backgroundColor: Theme.of(
                                      context,
                                    ).primaryColor.withValues(alpha: 0.1),
                                  );
                                }).toList() ??
                                [],
                          ),
                          const SizedBox(height: 100),
                          // Space for floating button
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _loading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _error(String message) {
    return Center(
      child: Text(message.isNotEmpty ? message : 'An error occurred'),
    );
  }

  Widget _buildServiceItem(BuildContext context, Service service) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          // Service image
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.network(
              service.image ?? '',
              width: 50,
              height: 50,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 50,
                  height: 50,
                  color: Colors.grey[300],
                  child: const Icon(Icons.build, color: Colors.grey),
                );
              },
            ),
          ),
          const SizedBox(width: 12),
          // Service details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  service.name ?? 'Service',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (service.description?.isNotEmpty ?? false) ...[
                  const SizedBox(height: 4),
                  Text(
                    service.description ?? '',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey[600],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      '৳${service.price?.toStringAsFixed(0)}',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Icon(Icons.access_time, size: 14, color: Colors.grey[600]),
                    const SizedBox(width: 4),
                    Text(
                      '${service.estimatedTime} min',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGarageCard(BuildContext context, Garage garage) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              garage.name ?? 'Garage',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.location_on, size: 16, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    '${garage.address}, ${garage.city}, ${garage.country}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.phone, size: 16, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text(
                  garage.contact?.phone ?? 'N/A',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(width: 16),
                Icon(Icons.email, size: 16, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    garage.contact?.email ?? 'N/A',
                    style: Theme.of(context).textTheme.bodyMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildManufacturerItem(
    BuildContext context,
    Manufacturer manufacturer,
  ) {
    return Container(
      width: 80,
      margin: const EdgeInsets.only(right: 12),
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
