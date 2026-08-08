
import 'dart:typed_data';

class CreatePortfolioEntity {
  const CreatePortfolioEntity({
    required this.labId,
    required this.orderId,
    required this.caseName,
    required this.beforeImage,
    required this.afterImage,
    this.beforeImageName,
    this.afterImageName,
    required this.isPublished,
  });

  final int labId;
  final int orderId;
  final String caseName;
  final Uint8List beforeImage;
  final Uint8List afterImage;

  final String? beforeImageName;
  final String? afterImageName;
  final bool isPublished;
}
