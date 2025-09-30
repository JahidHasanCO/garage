import 'package:equatable/equatable.dart';

class Manufacturer extends Equatable {
  const Manufacturer({
    this.id,
    this.name,
    this.country,
    this.logo,
    this.founded,
    this.website,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Manufacturer.fromJson(Map<String, dynamic> json) => Manufacturer(
    id: json['_id'] as String?,
    name: json['name'] as String?,
    country: json['country'] as String?,
    logo: json['logo'] as String?,
    founded: json['founded'] is int
        ? json['founded'] as int?
        : int.tryParse(json['founded']?.toString() ?? ''),
    website: json['website'] as String?,
    createdAt: json['createdAt'] == null
        ? null
        : DateTime.parse(json['createdAt'] as String),
    updatedAt: json['updatedAt'] == null
        ? null
        : DateTime.parse(json['updatedAt'] as String),
    v: json['__v'] is int
        ? json['__v'] as int?
        : int.tryParse(json['__v']?.toString() ?? ''),
  );

  final String? id;
  final String? name;
  final String? country;
  final String? logo;
  final int? founded;
  final String? website;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  @override
  List<Object?> get props => [
    id,
    name,
    country,
    logo,
    founded,
    website,
    createdAt,
    updatedAt,
    v,
  ];
}
