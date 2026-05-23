enum LabsTabType { active, inactive }

extension LabsTabTypeX on LabsTabType {
  String get apiPath => switch (this) {
    LabsTabType.active => '/auth/labs',
    LabsTabType.inactive => '/auth/labs/inactive',
  };
}

class LabsQueryParams {
  const LabsQueryParams({
    required this.tab,
    required this.page,
    this.perPage = 15,
  });

  final LabsTabType tab;
  final int page;
  final int perPage;
}
