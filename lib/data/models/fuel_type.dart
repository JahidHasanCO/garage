import 'package:equatable/equatable.dart';

class FuelType extends Equatable {
  const FuelType({
    this.id,
    this.title,
    this.value,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory FuelType.fromJson(Map<String, dynamic> json) => FuelType(
    id: json['_id'] as String?,
    title: json['title'] as String?,
    value: json['value'] as String?,
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
  final String? title;
  final String? value;
  final String? image;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  @override
  List<Object?> get props => [
    id,
    title,
    value,
    image,
    createdAt,
    updatedAt,
    v,
  ];
}
