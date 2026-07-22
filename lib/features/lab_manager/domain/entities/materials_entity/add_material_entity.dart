import 'package:equatable/equatable.dart';

class AddMaterialEntity extends Equatable {
   final int? id;
  final String name;
  final String description;
  final String category;
  final double price;

  const AddMaterialEntity({
    this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.price,
  });

  @override
  List<Object?> get props => [
        name,
        description,
        category,
        price,
      
      ];

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "description": description,
      "category": category,
      "price": price,
    };
  }
}