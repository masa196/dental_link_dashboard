import 'package:equatable/equatable.dart';

class UpdatePackageEntity extends Equatable {
  final int id;

  final String? name;
  final String? description;
  final int? durationDays;
  final double? price;
  final bool? isActive;

  const UpdatePackageEntity({
    required this.id,
    this.name,
    this.description,
    this.durationDays,
    this.price,
     this.isActive,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        durationDays,
        price,
        isActive,
      ];

  Map<String, dynamic> toJson() {
    return {
      if (name != null) "name": name,
      if (description != null) "description": description,
      if (durationDays != null) "duration_days": durationDays,
      if (price != null) "price": price,
      if (isActive != null) "is_active": isActive,
    };
  }
}