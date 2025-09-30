import 'package:equatable/equatable.dart';

class Part extends Equatable {
  const Part({
    this.id,
    this.name,
    this.price,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Part.fromJson(Map<String, dynamic> json) => Part(
    id: json['_id'] as String?,
    name: json['name'] as String?,
    price: json['price'] is int
        ? json['price'] as int?
        : int.tryParse(json['price']?.toString() ?? ''),
    image: json['image'] as String?,
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
  final int? price;
  final String? image;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  @override
  List<Object?> get props => [
    id,
    name,
    price,
    image,
    createdAt,
    updatedAt,
    v,
  ];
}
