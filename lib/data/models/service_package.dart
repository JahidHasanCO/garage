import 'package:equatable/equatable.dart';

class ServicePackage extends Equatable {
  const ServicePackage({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.duration,
    required this.services,
    required this.applicableFuelTypes,
    required this.applicableManufacturers,
    required this.garages,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String name;
  final String description;
  final double price;
  final int duration;
  final List<Service> services;
  final List<FuelType> applicableFuelTypes;
  final List<Manufacturer> applicableManufacturers;
  final List<Garage> garages;
  final String image;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory ServicePackage.fromJson(Map<String, dynamic> json) {
    return ServicePackage(
      id: json['_id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      duration: json['duration'] as int,
      services: (json['services'] as List<dynamic>)
          .map((e) => Service.fromJson(e as Map<String, dynamic>))
          .toList(),
      applicableFuelTypes: (json['applicableFuelTypes'] as List<dynamic>)
          .map((e) => FuelType.fromJson(e as Map<String, dynamic>))
          .toList(),
      applicableManufacturers: (json['applicableManufacturers'] as List<dynamic>)
          .map((e) => Manufacturer.fromJson(e as Map<String, dynamic>))
          .toList(),
      garages: (json['garages'] as List<dynamic>)
          .map((e) => Garage.fromJson(e as Map<String, dynamic>))
          .toList(),
      image: json['image'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

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
      ];
}

class Service extends Equatable {
  const Service({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.estimatedTime,
    required this.partsNeeded,
    required this.image,
    required this.discount,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String name;
  final String description;
  final double price;
  final int estimatedTime;
  final List<String> partsNeeded;
  final String image;
  final double discount;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['_id'] as String,
      name: json['name'] as String,
      description: json['description'] as String? ?? '',
      price: (json['price'] as num).toDouble(),
      estimatedTime: json['estimated_time'] as int,
      partsNeeded: (json['parts_needed'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      image: json['image'] as String,
      discount: (json['discount'] as num).toDouble(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

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
      ];
}

class FuelType extends Equatable {
  const FuelType({
    required this.id,
    required this.title,
    required this.value,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String title;
  final String value;
  final String image;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory FuelType.fromJson(Map<String, dynamic> json) {
    return FuelType(
      id: json['_id'] as String,
      title: json['title'] as String,
      value: json['value'] as String,
      image: json['image'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  @override
  List<Object?> get props => [id, title, value, image, createdAt, updatedAt];
}

class Manufacturer extends Equatable {
  const Manufacturer({
    required this.id,
    required this.name,
    required this.country,
    required this.logo,
    required this.founded,
    required this.website,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String name;
  final String country;
  final String logo;
  final int founded;
  final String website;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory Manufacturer.fromJson(Map<String, dynamic> json) {
    return Manufacturer(
      id: json['_id'] as String,
      name: json['name'] as String,
      country: json['country'] as String,
      logo: json['logo'] as String,
      founded: json['founded'] as int,
      website: json['website'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

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
      ];
}

class Garage extends Equatable {
  const Garage({
    required this.id,
    required this.name,
    required this.address,
    required this.city,
    required this.country,
    required this.geo,
    required this.contact,
    required this.supportedManufacturers,
    required this.supportedFuelTypes,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String name;
  final String address;
  final String city;
  final String country;
  final GeoLocation geo;
  final Contact contact;
  final List<String> supportedManufacturers;
  final List<String> supportedFuelTypes;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory Garage.fromJson(Map<String, dynamic> json) {
    return Garage(
      id: json['_id'] as String,
      name: json['name'] as String,
      address: json['address'] as String,
      city: json['city'] as String,
      country: json['country'] as String,
      geo: GeoLocation.fromJson(json['geo'] as Map<String, dynamic>),
      contact: Contact.fromJson(json['contact'] as Map<String, dynamic>),
      supportedManufacturers: (json['supportedManufacturers'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      supportedFuelTypes: (json['supportedFuelTypes'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        address,
        city,
        country,
        geo,
        contact,
        supportedManufacturers,
        supportedFuelTypes,
        createdAt,
        updatedAt,
      ];
}

class GeoLocation extends Equatable {
  const GeoLocation({
    required this.lat,
    required this.lng,
  });

  final double lat;
  final double lng;

  factory GeoLocation.fromJson(Map<String, dynamic> json) {
    return GeoLocation(
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
    );
  }

  @override
  List<Object?> get props => [lat, lng];
}

class Contact extends Equatable {
  const Contact({
    required this.phone,
    required this.email,
  });

  final String phone;
  final String email;

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      phone: json['phone'] as String,
      email: json['email'] as String,
    );
  }

  @override
  List<Object?> get props => [phone, email];
}

class ServicePackagesResponse extends Equatable {
  const ServicePackagesResponse({
    required this.packages,
    required this.total,
    required this.page,
    required this.pages,
  });

  final List<ServicePackage> packages;
  final int total;
  final int page;
  final int pages;

  factory ServicePackagesResponse.fromJson(Map<String, dynamic> json) {
    return ServicePackagesResponse(
      packages: (json['packages'] as List<dynamic>)
          .map((e) => ServicePackage.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: json['total'] as int,
      page: json['page'] as int,
      pages: json['pages'] as int,
    );
  }

  @override
  List<Object?> get props => [packages, total, page, pages];
}