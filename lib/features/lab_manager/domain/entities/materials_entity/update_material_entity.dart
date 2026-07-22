import 'package:equatable/equatable.dart';

class UpdateMaterialEntity extends Equatable {
  final int id;

  final String? name;
  final String? description;
  final String? category;
  final double? price;

  const UpdateMaterialEntity({
    required this.id,
    this.name,
    this.description,
    this.category,
    this.price,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        category,
        price,
      ];

  Map<String, dynamic> toJson() {
    return {
      if (name != null) "name": name,
      if (description != null) "description": description,
      if (category != null) "category": category,
      if (price != null) "price": price,
    };
  }
}