import 'package:equatable/equatable.dart';

class Service extends Equatable {
  const Service({
    this.id,
    this.name,
    this.description,
    this.price,
    this.estimatedTime,
    this.partsNeeded,
    this.image,
    this.discount,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Service.fromJson(Map<String, dynamic> json) => Service(
    id: json['_id'] as String?,
    name: json['name'] as String?,
    description: json['description'] as String?,
    price: json['price'] is int
        ? json['price'] as int?
        : int.tryParse(json['price']?.toString() ?? ''),
    estimatedTime: json['estimated_time'] is int
        ? json['estimated_time'] as int?
        : int.tryParse(json['estimated_time']?.toString() ?? ''),
    partsNeeded: json['parts_needed'] == null
        ? []
        : List<dynamic>.from(
            (json['parts_needed'] as List<dynamic>? ?? []).map((x) => x),
          ),
    image: json['image'] as String?,
    discount: json['discount'] is int
        ? json['discount'] as int?
        : int.tryParse(json['discount']?.toString() ?? ''),
    createdAt: json['createdAt'] == null
        ? null
        : DateTime.tryParse(json['createdAt'].toString()),
    updatedAt: json['updatedAt'] == null
        ? null
        : DateTime.tryParse(json['updatedAt'].toString()),
    v: json['__v'] is int
        ? json['__v'] as int?
        : int.tryParse(json['__v']?.toString() ?? ''),
  );

  final String? id;
  final String? name;
  final String? description;
  final int? price;
  final int? estimatedTime;
  final List<dynamic>? partsNeeded;
  final String? image;
  final int? discount;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    price,
    estimatedTime,
    partsNeeded,
    image,
    discount,
    createdAt,
    updatedAt,
    v,
  ];
}
