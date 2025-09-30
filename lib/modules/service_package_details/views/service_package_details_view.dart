import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garage/core/provider/provider.dart';
import 'package:garage/modules/service_package_details/service_package_details.dart';
import 'package:garage/theme/app_colors.dart';

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
      backgroundColor: AppColors.backgroundColor,
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
                          background: CachedNetworkImage(
                            imageUrl: state.package!.image!,
                            cacheKey: state.package!.id,
                            fit: BoxFit.cover,
                            errorWidget: (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey[100],
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
                                style: Theme.of(context).textTheme.titleLarge
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 6,
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
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        if (state.package?.description != null &&
                            state.package!.description!.isNotEmpty) ...[
                          Text(
                            'Description',
                            style: Theme.of(context).textTheme.titleMedium
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
                          const SizedBox(height: 12),
                        ],
                        ServiceList(data: state.package?.services ?? []),
                        const SizedBox(height: 10),
                        ServiceProviderWidget(
                          garageList: state.package?.garages ?? [],
                        ),
                        SupportedCarBrands(
                          brands: state.package?.applicableManufacturers ?? [],
                        ),
                        // Fuel types
                        SupportedFuelTypes(
                          fuelTypes: state.package?.applicableFuelTypes ?? [],
                        ),
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
}
