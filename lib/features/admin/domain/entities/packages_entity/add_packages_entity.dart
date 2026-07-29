import 'package:equatable/equatable.dart';

class AddPackageEntity extends Equatable {
   final int? id;
  final String name;
  final String description;
  final int durationDays;
  final double price;
  final bool isActive;

  const AddPackageEntity({
    this.id,
    required this.name,
    required this.description,
    required this.durationDays,
    required this.price,
    required this.isActive,
  });

  

  @override
  List<Object?> get props => [
        name,
        description,
        durationDays,
        price,
        isActive,
      
      ];

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "description": description,
      "duration_days": durationDays,
      "price": price,
      "is_active": isActive,
    };
  }
}