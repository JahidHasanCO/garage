import 'package:equatable/equatable.dart';
import 'package:garage/data/models/contact.dart';
import 'package:garage/data/models/geo.dart';
import 'package:garage/data/models/location.dart';

class Garage extends Equatable {
  const Garage({
    this.geo,
    this.location,
    this.contact,
    this.id,
    this.name,
    this.address,
    this.city,
    this.country,
    this.supportedManufacturers,
    this.supportedFuelTypes,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Garage.fromJson(Map<String, dynamic> json) => Garage(
    geo: json['geo'] is Map<String, dynamic>
        ? Geo.fromJson(json['geo'] as Map<String, dynamic>)
        : null,
    location: json['location'] is Map<String, dynamic>
        ? Location.fromJson(json['location'] as Map<String, dynamic>)
        : null,
    contact: json['contact'] is Map<String, dynamic>
        ? Contact.fromJson(json['contact'] as Map<String, dynamic>)
        : null,
    id: json['_id'] as String?,
    name: json['name'] as String?,
    address: json['address'] as String?,
    city: json['city'] as String?,
    country: json['country'] as String?,
    supportedManufacturers: json['supportedManufacturers'] is List
        ? List<String>.from(
            (json['supportedManufacturers'] as List).map((x) => x as String),
          )
        : [],
    supportedFuelTypes: json['supportedFuelTypes'] is List
        ? List<String>.from(
            (json['supportedFuelTypes'] as List).map((x) => x as String),
          )
        : [],
    createdAt: json['createdAt'] is String
        ? DateTime.parse(json['createdAt'] as String)
        : null,
    updatedAt: json['updatedAt'] is String
        ? DateTime.parse(json['updatedAt'] as String)
        : null,
    v: json['__v'] is int ? json['__v'] as int : null,
  );

  final Geo? geo;
  final Location? location;
  final Contact? contact;
  final String? id;
  final String? name;
  final String? address;
  final String? city;
  final String? country;
  final List<String>? supportedManufacturers;
  final List<String>? supportedFuelTypes;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  @override
  List<Object?> get props => [
    geo,
    location,
    contact,
    id,
    name,
    address,
    city,
    country,
    supportedManufacturers,
    supportedFuelTypes,
    createdAt,
    updatedAt,
    v,
  ];
}
