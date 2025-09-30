import 'package:garage/data/models/garage.dart';

class NearbyGarageListResponse {
  NearbyGarageListResponse({
    this.garages,
    this.total,
    this.page,
    this.pages,
  });

  factory NearbyGarageListResponse.fromJson(Map<String, dynamic> json) =>
      NearbyGarageListResponse(
        garages: json['garages'] is List
            ? (json['garages'] as List)
                  .whereType<Map<String, dynamic>>()
                  .map(Garage.fromJson)
                  .toList()
            : [],
        total: json['total'] is int ? json['total'] as int : null,
        page: json['page'] is int ? json['page'] as int : null,
        pages: json['pages'] is int ? json['pages'] as int : null,
      );

  final List<Garage>? garages;
  final int? total;
  final int? page;
  final int? pages;
}
