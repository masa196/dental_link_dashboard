// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orders_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllOrdersResponse _$AllOrdersResponseFromJson(Map<String, dynamic> json) =>
    AllOrdersResponse(
      success: json['success'] as bool?,
      status: (json['status'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
      errors: json['errors'],
    );

Data _$DataFromJson(Map<String, dynamic> json) => Data(
  currentPage: (json['current_page'] as num?)?.toInt(),
  data: (json['data'] as List<dynamic>?)
      ?.map((e) => OrderModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  firstPageUrl: json['first_page_url'] as String?,
  from: (json['from'] as num?)?.toInt(),
  lastPage: (json['last_page'] as num?)?.toInt(),
  lastPageUrl: json['last_page_url'] as String?,
  links: (json['links'] as List<dynamic>?)
      ?.map((e) => Link.fromJson(e as Map<String, dynamic>))
      .toList(),
  nextPageUrl: json['next_page_url'],
  path: json['path'] as String?,
  perPage: (json['per_page'] as num?)?.toInt(),
  prevPageUrl: json['prev_page_url'],
  to: (json['to'] as num?)?.toInt(),
  total: (json['total'] as num?)?.toInt(),
);

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
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
  remainingDays: (json['remaining_days'] as num?)?.toInt(),
  toothShadeName: json['tooth_shade_name'] as String?,
  materialType: json['material_type'] as String?,
  price: json['price'] as String?,
  remainingAmount: json['remaining_amount'] as String?,
  paidAmount: json['paid_amount'] as String?,
  orderTeethCount: (json['order_teeth_count'] as num?)?.toInt(),
  teeth: (json['teeth'] as List<dynamic>?)
      ?.map((e) => (e as num).toInt())
      .toList(),
  files: (json['files'] as List<dynamic>?)
      ?.map((e) => FileElement.fromJson(e as Map<String, dynamic>))
      .toList(),
  departments: (json['departments'] as List<dynamic>?)
      ?.map((e) => Department.fromJson(e as Map<String, dynamic>))
      .toList(),
  currentDepartment: json['current_department'] == null
      ? null
      : Department.fromJson(json['current_department'] as Map<String, dynamic>),
  requiresResubmission: json['requires_resubmission'] as bool?,
  resubmissionReason: json['resubmission_reason'],
  resubmissionRequestedAt: json['resubmission_requested_at'],
  qrPrintedAt: json['qr_printed_at'] == null
      ? null
      : DateTime.parse(json['qr_printed_at'] as String),
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  doctor: json['doctor'] == null
      ? null
      : Doctor.fromJson(json['doctor'] as Map<String, dynamic>),
  lab: json['lab'] == null
      ? null
      : Lab.fromJson(json['lab'] as Map<String, dynamic>),
);

Department _$DepartmentFromJson(Map<String, dynamic> json) => Department(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String?,
  sortOrder: (json['sort_order'] as num?)?.toInt(),
  taskId: (json['task_id'] as num?)?.toInt(),
  status: json['status'] as String?,
  approvedAt: json['approved_at'] == null
      ? null
      : DateTime.parse(json['approved_at'] as String),
  timeAllowedHours: (json['time_allowed_hours'] as num?)?.toInt(),
  isManagement: json['is_management'] as bool?,
  isCurrent: json['is_current'] as bool?,
);

Doctor _$DoctorFromJson(Map<String, dynamic> json) => Doctor(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String?,
  email: json['email'] as String?,
  phone: json['phone'] as String?,
  location: json['location'] as String?,
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

Link _$LinkFromJson(Map<String, dynamic> json) => Link(
  url: json['url'] as String?,
  label: json['label'] as String?,
  page: (json['page'] as num?)?.toInt(),
  active: json['active'] as bool?,
);
