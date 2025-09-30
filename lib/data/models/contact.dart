import 'package:equatable/equatable.dart';

class Contact extends Equatable {
  const Contact({this.phone, this.email});

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
    phone: json['phone'] as String?,
    email: json['email'] as String?,
  );

  final String? phone;
  final String? email;

  @override
  List<Object?> get props => [phone, email];
}
