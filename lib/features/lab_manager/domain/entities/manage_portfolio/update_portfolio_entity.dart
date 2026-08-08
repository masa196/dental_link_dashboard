import 'dart:typed_data';

class UpdatePortfolioEntity {
  const UpdatePortfolioEntity({
    required this.labId,
    required this.portfolioId,
    required this.caseName,
    this.beforeImage,
    this.afterImage,
    this.beforeImageName,
    this.afterImageName,
    required this.isPublished,
  });

  final int labId;
  final int portfolioId;
  final String caseName;

  final Uint8List? beforeImage;
  final Uint8List? afterImage;

  final String? beforeImageName;
  final String? afterImageName;

  final bool isPublished;
}