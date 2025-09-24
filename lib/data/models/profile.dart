import 'dart:convert';

import 'package:equatable/equatable.dart';

class Profile extends Equatable {
  const Profile({
    required this.id,
    required this.address,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Profile.fromJson(String source) =>
      Profile.fromMap(jsonDecode(source) as Map<String, dynamic>);

  factory Profile.fromMap(Map<String, dynamic> json) => Profile(
    id: json['_id'] as String? ?? '',
    address: json['address'] as String? ?? '',
    userId: json['user_id'] as String? ?? '',
    createdAt: json['createdAt'] == null
        ? DateTime.now()
        : DateTime.parse(json['createdAt'] as String),
    updatedAt: json['updatedAt'] == null
        ? DateTime.now()
        : DateTime.parse(json['updatedAt'] as String),
  );

  final String id;
  final String address;
  final String userId;
  final DateTime createdAt;
  final DateTime updatedAt;

  Profile copyWith({
    String? id,
    String? address,
    String? userId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Profile(
      id: id ?? this.id,
      address: address ?? this.address,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'address': address,
      'userId': userId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  String toJson() => jsonEncode(toMap());

  @override
  List<Object?> get props => [id, address, userId, createdAt, updatedAt];
}
