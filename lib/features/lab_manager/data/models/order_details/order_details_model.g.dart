// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderDetailsResponse _$OrderDetailsResponseFromJson(
  Map<String, dynamic> json,
) => OrderDetailsResponse(
  success: json['success'] as bool?,
  status: (json['status'] as num?)?.toInt(),
  message: json['message'] as String?,
  data: json['data'] == null
      ? null
      : Data.fromJson(json['data'] as Map<String, dynamic>),
  errors: json['errors'],
);

Data _$DataFromJson(Map<String, dynamic> json) => Data(
  orderdetails: json['order'] == null
      ? null
      : OrderDetails.fromJson(json['order'] as Map<String, dynamic>),
  lock: json['lock'] == null
      ? null
      : Lock.fromJson(json['lock'] as Map<String, dynamic>),
);

Lock _$LockFromJson(Map<String, dynamic> json) => Lock(
  isLocked: json['is_locked'] as bool?,
  lockedBy: json['locked_by'],
  lockedByName: json['locked_by_name'],
);

OrderDetails _$OrderDetailsFromJson(Map<String, dynamic> json) => OrderDetails(
  id: (json['id'] as num?)?.toInt(),
  qrCode: json['qr_code'] as String?,
  caseType: json['case_type'] as String?,
  priority: json['priority'] as String?,
  status: json['status'] as String?,
  orderType: json['order_type'] as String?,
  patientName: json['patient_name'] as String?,
  serialNumber: json['serial_number'] as String?,
  receivedAt: json['received_at'] == null
      ? null
      : DateTime.parse(json['received_at'] as String),
  deliveredAt: json['delivered_at'] == null
      ? null
      : DateTime.parse(json['delivered_at'] as String),
  startDate: json['start_date'] == null
      ? null
      : DateTime.parse(json['start_date'] as String),
  endDate: json['end_date'] == null
      ? null
      : DateTime.parse(json['end_date'] as String),
  elapsedTime: json['elapsed_time'] == null
      ? null
      : ElapsedTime.fromJson(json['elapsed_time'] as Map<String, dynamic>),
  remainingTime: json['remaining_time'] == null
      ? null
      : RemainingTime.fromJson(json['remaining_time'] as Map<String, dynamic>),
  estimatedTotalHours: (json['estimated_total_hours'] as num?)?.toInt(),
  notes: json['notes'] as String?,
  price: json['price'] as String?,
  remainingAmount: json['remaining_amount'] as String?,
  paidAmount: json['paid_amount'] as String?,
  isPaid: json['is_paid'] as bool?,
  beforeImagePath: json['before_image_path'],
  afterImagePath: json['after_image_path'],
  requiresResubmission: json['requires_resubmission'] as bool?,
  resubmissionReason: json['resubmission_reason'],
  resubmissionRequestedAt: json['resubmission_requested_at'],
  toothShadeName: json['tooth_shade_name'] as String?,
  materialType: json['material_type'] as String?,
  caseName: json['case_name'],
  isPublished: json['is_published'],
  portfolioId: (json['portfolio_id'] as num?)?.toInt(),
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
  doctor: json['doctor'] == null
      ? null
      : Doctor.fromJson(json['doctor'] as Map<String, dynamic>),
  lab: json['lab'] == null
      ? null
      : Lab.fromJson(json['lab'] as Map<String, dynamic>),
  teeth: (json['teeth'] as List<dynamic>?)
      ?.map((e) => Tooth.fromJson(e as Map<String, dynamic>))
      .toList(),
  files: (json['files'] as List<dynamic>?)
      ?.map((e) => FileElement.fromJson(e as Map<String, dynamic>))
      .toList(),
  tasks: (json['tasks'] as List<dynamic>?)
      ?.map((e) => Task.fromJson(e as Map<String, dynamic>))
      .toList(),
  payments: json['payments'] as List<dynamic>?,
);

Doctor _$DoctorFromJson(Map<String, dynamic> json) => Doctor(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String?,
  email: json['email'] as String?,
  phone: json['phone'] as String?,
  location: json['location'] as String?,
);

ElapsedTime _$ElapsedTimeFromJson(Map<String, dynamic> json) => ElapsedTime(
  minutes: (json['minutes'] as num?)?.toInt(),
  human: json['human'] as String?,
);

FileElement _$FileElementFromJson(Map<String, dynamic> json) => FileElement(
  id: (json['id'] as num?)?.toInt(),
  filePath: json['file_path'] as String?,
  fileType: json['file_type'] as String?,
  uploadedAt: json['uploaded_at'] == null
      ? null
      : DateTime.parse(json['uploaded_at'] as String),
);

Lab _$LabFromJson(Map<String, dynamic> json) => Lab(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String?,
  phone: json['phone'] as String?,
  address: json['address'] as String?,
);

RemainingTime _$RemainingTimeFromJson(Map<String, dynamic> json) =>
    RemainingTime(
      minutes: (json['minutes'] as num?)?.toInt(),
      human: json['human'] as String?,
      isOverdue: json['is_overdue'] as bool?,
    );

Task _$TaskFromJson(Map<String, dynamic> json) => Task(
  id: (json['id'] as num?)?.toInt(),
  status: json['status'] as String?,
  approvedAt: json['approved_at'],
  department: json['department'] == null
      ? null
      : Department.fromJson(json['department'] as Map<String, dynamic>),
  employee: json['employee'] == null
      ? null
      : Employee.fromJson(json['employee'] as Map<String, dynamic>),
);

Department _$DepartmentFromJson(Map<String, dynamic> json) => Department(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String?,
);

Employee _$EmployeeFromJson(Map<String, dynamic> json) => Employee(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String?,
  email: json['email'] as String?,
);

Tooth _$ToothFromJson(Map<String, dynamic> json) => Tooth(
  id: (json['id'] as num?)?.toInt(),
  orderId: (json['order_id'] as num?)?.toInt(),
  toothNumber: (json['tooth_number'] as num?)?.toInt(),
  notes: json['notes'] as String?,
);
