import 'package:equatable/equatable.dart';
import 'package:garage/data/models/fuel_type.dart';
import 'package:garage/data/models/garage.dart';
import 'package:garage/data/models/manufacturer.dart';
import 'package:garage/data/models/service.dart';

class ServicePackage extends Equatable{
  const ServicePackage({
    this.id,
    this.name,
    this.description,
    this.price,
    this.duration,
    this.services,
    this.applicableFuelTypes,
    this.applicableManufacturers,
    this.garages,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory ServicePackage.fromJson(Map<String, dynamic> json) => ServicePackage(
    id: json['_id'] as String?,
    name: json['name'] as String?,
    description: json['description'] as String?,
    price: (json['price'] is num) ? (json['price'] as num).toDouble() : null,
    duration: json['duration'] as int?,
    services: json['services'] == null
        ? []
        : List<Service>.from(
            (json['services'] as List<dynamic>).map(
              (x) => Service.fromJson(x as Map<String, dynamic>),
            ),
          ),
    applicableFuelTypes: json['applicableFuelTypes'] == null
        ? []
        : List<FuelType>.from(
            (json['applicableFuelTypes'] as List<dynamic>).map(
              (x) => FuelType.fromJson(x as Map<String, dynamic>),
            ),
          ),
    applicableManufacturers: json['applicableManufacturers'] == null
        ? []
        : List<Manufacturer>.from(
            (json['applicableManufacturers'] as List<dynamic>).map(
              (x) => Manufacturer.fromJson(x as Map<String, dynamic>),
            ),
          ),
    garages: json['garages'] == null
        ? []
        : List<Garage>.from(
            (json['garages'] as List<dynamic>).map(
              (x) => Garage.fromJson(x as Map<String, dynamic>),
            ),
          ),
    image: json['image'] as String?,
    createdAt: json['createdAt'] == null
        ? null
        : DateTime.parse(json['createdAt'] as String),
    updatedAt: json['updatedAt'] == null
        ? null
        : DateTime.parse(json['updatedAt'] as String),
    v: json['__v'] as int?,
  );

  final String? id;
  final String? name;
  final String? description;
  final double? price;
  final int? duration;
  final List<Service>? services;
  final List<FuelType>? applicableFuelTypes;
  final List<Manufacturer>? applicableManufacturers;
  final List<Garage>? garages;
  final String? image;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    price,
    duration,
    services,
    applicableFuelTypes,
    applicableManufacturers,
    garages,
    image,
    createdAt,
    updatedAt,
    v,
  ];
}
