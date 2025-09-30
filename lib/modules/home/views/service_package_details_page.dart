import 'package:flutter/material.dart';
import 'package:garage/data/models/service_package.dart';

class ServicePackageDetailsPage extends StatelessWidget {
  const ServicePackageDetailsPage({
    required this.package,
    super.key,
  });

  final ServicePackage package;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App bar with image
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            flexibleSpace: package.image != null ? FlexibleSpaceBar(
              background: Image.network(
                package.image!,
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
            ) : null,
            actions: [
              IconButton(
                onPressed: () {

                },
                icon: const Icon(Icons.favorite_border),
              ),
            ],
          ),
          // Content
          // SliverToBoxAdapter(
          //   child: Padding(
          //     padding: const EdgeInsets.all(16),
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         // Package name and price
          //         Row(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             Expanded(
          //               child: Text(
          //                 package.name ?? 'Service Package',
          //                 style: Theme.of(context).textTheme.headlineMedium?.copyWith(
          //                   fontWeight: FontWeight.bold,
          //                 ),
          //               ),
          //             ),
          //             const SizedBox(width: 16),
          //             Container(
          //               padding: const EdgeInsets.symmetric(
          //                 horizontal: 12,
          //                 vertical: 8,
          //               ),
          //               decoration: BoxDecoration(
          //                 color: Theme.of(context).primaryColor,
          //                 borderRadius: BorderRadius.circular(8),
          //               ),
          //               child: Text(
          //                 '৳${package.price?.toStringAsFixed(0)}',
          //                 style: const TextStyle(
          //                   color: Colors.white,
          //                   fontWeight: FontWeight.bold,
          //                   fontSize: 18,
          //                 ),
          //               ),
          //             ),
          //           ],
          //         ),
          //         const SizedBox(height: 16),
          //
          //         // Description
          //         Text(
          //           'Description',
          //           style: Theme.of(context).textTheme.titleLarge?.copyWith(
          //             fontWeight: FontWeight.w600,
          //           ),
          //         ),
          //         const SizedBox(height: 8),
          //         Text(
          //           package.description ?? 'No description available.',
          //           style: Theme.of(context).textTheme.bodyMedium,
          //         ),
          //         const SizedBox(height: 24),
          //
          //         // Services included
          //         Text(
          //           'Services Included (${package.services?.length})',
          //           style: Theme.of(context).textTheme.titleLarge?.copyWith(
          //             fontWeight: FontWeight.w600,
          //           ),
          //         ),
          //         const SizedBox(height: 12),
          //         ...package.services.map((service) => _buildServiceItem(context, service)),
          //         const SizedBox(height: 24),
          //
          //         // Garage information
          //         if (package.garages.isNotEmpty) ...[
          //           Text(
          //             'Service Provider',
          //             style: Theme.of(context).textTheme.titleLarge?.copyWith(
          //               fontWeight: FontWeight.w600,
          //             ),
          //           ),
          //           const SizedBox(height: 12),
          //           _buildGarageCard(context, package.garages.first),
          //           const SizedBox(height: 24),
          //         ],
          //
          //         // Applicable manufacturers
          //         if (package.applicableManufacturers.isNotEmpty) ...[
          //           Text(
          //             'Supported Car Brands',
          //             style: Theme.of(context).textTheme.titleLarge?.copyWith(
          //               fontWeight: FontWeight.w600,
          //             ),
          //           ),
          //           const SizedBox(height: 12),
          //           SizedBox(
          //             height: 80,
          //             child: ListView.builder(
          //               scrollDirection: Axis.horizontal,
          //               itemCount: package.applicableManufacturers.length,
          //               itemBuilder: (context, index) {
          //                 final manufacturer = package.applicableManufacturers[index];
          //                 return _buildManufacturerItem(context, manufacturer);
          //               },
          //             ),
          //           ),
          //           const SizedBox(height: 24),
          //         ],
          //
          //         // Fuel types
          //         if (package.applicableFuelTypes.isNotEmpty) ...[
          //           Text(
          //             'Supported Fuel Types',
          //             style: Theme.of(context).textTheme.titleLarge?.copyWith(
          //               fontWeight: FontWeight.w600,
          //             ),
          //           ),
          //           const SizedBox(height: 12),
          //           Wrap(
          //             spacing: 8,
          //             runSpacing: 8,
          //             children: package.applicableFuelTypes.map((fuelType) {
          //               return Chip(
          //                 label: Text(fuelType.title),
          //                 backgroundColor: Theme.of(context).primaryColor.withValues(alpha: 0.1),
          //               );
          //             }).toList(),
          //           ),
          //           const SizedBox(height: 100), // Space for floating button
          //         ],
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // TODO: Book service
          _showBookingDialog(context);
        },
        label: const Text('Book Service'),
        icon: const Icon(Icons.calendar_today),
      ),
    );
  }

  // Widget _buildServiceItem(BuildContext context, Service service) {
  //   return Container(
  //     margin: const EdgeInsets.only(bottom: 12),
  //     padding: const EdgeInsets.all(12),
  //     decoration: BoxDecoration(
  //       border: Border.all(color: Colors.grey[300]!),
  //       borderRadius: BorderRadius.circular(8),
  //     ),
  //     child: Row(
  //       children: [
  //         // Service image
  //         ClipRRect(
  //           borderRadius: BorderRadius.circular(6),
  //           child: Image.network(
  //             service.image,
  //             width: 50,
  //             height: 50,
  //             fit: BoxFit.cover,
  //             errorBuilder: (context, error, stackTrace) {
  //               return Container(
  //                 width: 50,
  //                 height: 50,
  //                 color: Colors.grey[300],
  //                 child: const Icon(Icons.build, color: Colors.grey),
  //               );
  //             },
  //           ),
  //         ),
  //         const SizedBox(width: 12),
  //         // Service details
  //         Expanded(
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Text(
  //                 service.name,
  //                 style: Theme.of(context).textTheme.titleMedium?.copyWith(
  //                   fontWeight: FontWeight.w600,
  //                 ),
  //               ),
  //               if (service.description.isNotEmpty) ...[
  //                 const SizedBox(height: 4),
  //                 Text(
  //                   service.description,
  //                   style: Theme.of(context).textTheme.bodySmall?.copyWith(
  //                     color: Colors.grey[600],
  //                   ),
  //                   maxLines: 2,
  //                   overflow: TextOverflow.ellipsis,
  //                 ),
  //               ],
  //               const SizedBox(height: 4),
  //               Row(
  //                 children: [
  //                   Text(
  //                     '৳${service.price.toStringAsFixed(0)}',
  //                     style: Theme.of(context).textTheme.titleSmall?.copyWith(
  //                       color: Theme.of(context).primaryColor,
  //                       fontWeight: FontWeight.w600,
  //                     ),
  //                   ),
  //                   const SizedBox(width: 16),
  //                   Icon(Icons.access_time, size: 14, color: Colors.grey[600]),
  //                   const SizedBox(width: 4),
  //                   Text(
  //                     '${service.estimatedTime} min',
  //                     style: Theme.of(context).textTheme.bodySmall?.copyWith(
  //                       color: Colors.grey[600],
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
  //
  // Widget _buildGarageCard(BuildContext context, Garage garage) {
  //   return Card(
  //     child: Padding(
  //       padding: const EdgeInsets.all(16),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Text(
  //             garage.name,
  //             style: Theme.of(context).textTheme.titleMedium?.copyWith(
  //               fontWeight: FontWeight.w600,
  //             ),
  //           ),
  //           const SizedBox(height: 8),
  //           Row(
  //             children: [
  //               Icon(Icons.location_on, size: 16, color: Colors.grey[600]),
  //               const SizedBox(width: 4),
  //               Expanded(
  //                 child: Text(
  //                   '${garage.address}, ${garage.city}, ${garage.country}',
  //                   style: Theme.of(context).textTheme.bodyMedium,
  //                 ),
  //               ),
  //             ],
  //           ),
  //           const SizedBox(height: 8),
  //           Row(
  //             children: [
  //               Icon(Icons.phone, size: 16, color: Colors.grey[600]),
  //               const SizedBox(width: 4),
  //               Text(
  //                 garage.contact.phone,
  //                 style: Theme.of(context).textTheme.bodyMedium,
  //               ),
  //               const SizedBox(width: 16),
  //               Icon(Icons.email, size: 16, color: Colors.grey[600]),
  //               const SizedBox(width: 4),
  //               Expanded(
  //                 child: Text(
  //                   garage.contact.email,
  //                   style: Theme.of(context).textTheme.bodyMedium,
  //                   overflow: TextOverflow.ellipsis,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
  //
  // Widget _buildManufacturerItem(BuildContext context, Manufacturer manufacturer) {
  //   return Container(
  //     width: 80,
  //     margin: const EdgeInsets.only(right: 12),
  //     child: Column(
  //       children: [
  //         ClipRRect(
  //           borderRadius: BorderRadius.circular(8),
  //           child: Image.network(
  //             manufacturer.logo,
  //             width: 50,
  //             height: 50,
  //             fit: BoxFit.contain,
  //             errorBuilder: (context, error, stackTrace) {
  //               return Container(
  //                 width: 50,
  //                 height: 50,
  //                 color: Colors.grey[300],
  //                 child: const Icon(Icons.directions_car, color: Colors.grey),
  //               );
  //             },
  //           ),
  //         ),
  //         const SizedBox(height: 4),
  //         Text(
  //           manufacturer.name,
  //           style: Theme.of(context).textTheme.bodySmall,
  //           textAlign: TextAlign.center,
  //           maxLines: 1,
  //           overflow: TextOverflow.ellipsis,
  //         ),
  //       ],
  //     ),
  //   );
  // }

  void _showBookingDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Book Service'),
        content: Text('Booking functionality for "${package.name}" will be implemented here.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              // TODO: Implement booking logic
            },
            child: const Text('Book Now'),
          ),
        ],
      ),
    );
  }
}