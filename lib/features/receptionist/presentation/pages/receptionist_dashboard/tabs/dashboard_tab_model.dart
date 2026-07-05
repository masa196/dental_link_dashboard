class DashboardTabModel {
  final String title;
  final String count;


  const DashboardTabModel({
    required this.title,
    required this.count,

  });

  DashboardTabModel copyWith({
    String? title,
    String? count,
  }) {
    return DashboardTabModel(
      title: title ?? this.title,
      count: count ?? this.count,

    );
  }
}