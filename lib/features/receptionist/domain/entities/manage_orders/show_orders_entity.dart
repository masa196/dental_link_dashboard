import 'package:equatable/equatable.dart';

class ShowOrdersEntity extends Equatable {
  const ShowOrdersEntity({
    this.page = 1,
    this.perPage = 15,
    this.status,
    this.priority,
    this.doctorId,
    this.search,
    this.fromDate,
    this.toDate,
    this.sortBy,
    this.sortDirection,
    this.requiresResubmission,
  });

  final int page;
  final int perPage;

  final String? status;
  final String? priority;

  final int? doctorId;

  final String? search;

  final String? fromDate;
  final String? toDate;

  final String? sortBy;
  final String? sortDirection;

  final bool? requiresResubmission;

  Map<String, dynamic> toQueryParameters() {
    return {
      'page': page,
      'per_page': perPage,

      if (status != null && status != 'all') 'status': status,
      if (priority != null) 'priority': priority,
      if (doctorId != null) 'doctor_id': doctorId,
      if (search != null && search!.isNotEmpty) 'search': search,
      if (fromDate != null) 'from_date': fromDate,
      if (toDate != null) 'to_date': toDate,
      if (sortBy != null) 'sort_by': sortBy,
      if (sortDirection != null) 'sort_direction': sortDirection,
      if (requiresResubmission != null)
        'requires_resubmission': requiresResubmission,
    };
  }

  ShowOrdersEntity copyWith({
    int? page,
    int? perPage,
    String? status,
    String? priority,
    int? doctorId,
    String? search,
    String? fromDate,
    String? toDate,
    String? sortBy,
    String? sortDirection,
    bool? requiresResubmission,
  }) {
    return ShowOrdersEntity(
      page: page ?? this.page,
      perPage: perPage ?? this.perPage,
      status: status ?? this.status,
      priority: priority ?? this.priority,
      doctorId: doctorId ?? this.doctorId,
      search: search ?? this.search,
      fromDate: fromDate ?? this.fromDate,
      toDate: toDate ?? this.toDate,
      sortBy: sortBy ?? this.sortBy,
      sortDirection: sortDirection ?? this.sortDirection,
      requiresResubmission: requiresResubmission ?? this.requiresResubmission,
    );
  }

  @override
  List<Object?> get props => [
    page,
    perPage,
    status,
    priority,
    doctorId,
    search,
    fromDate,
    toDate,
    sortBy,
    sortDirection,
    requiresResubmission,
  ];
}
