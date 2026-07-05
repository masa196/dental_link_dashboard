import 'package:dental_link_dashboard/features/receptionist/presentation/pages/receptionist_dashboard/order_card/workflow/models/workflow_step.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'orders_model.g.dart';

@JsonSerializable(createToJson: false)
class AllOrdersResponse extends Equatable {
  const AllOrdersResponse({
    required this.success,
    required this.status,
    required this.message,
    required this.data,
    required this.errors,
  });

  final bool? success;
  final int? status;
  final String? message;
  final Data? data;
  final dynamic errors;

  factory AllOrdersResponse.fromJson(Map<String, dynamic> json) =>
      _$AllOrdersResponseFromJson(json);

  @override
  List<Object?> get props => [success, status, message, data, errors];
}

@JsonSerializable(createToJson: false)
class Data extends Equatable {
  const Data({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.links,
    required this.nextPageUrl,
    required this.path,
    required this.perPage,
    required this.prevPageUrl,
    required this.to,
    required this.total,
  });

  @JsonKey(name: 'current_page')
  final int? currentPage;
  final List<OrderModel>? data;

  @JsonKey(name: 'first_page_url')
  final String? firstPageUrl;
  final int? from;

  @JsonKey(name: 'last_page')
  final int? lastPage;

  @JsonKey(name: 'last_page_url')
  final String? lastPageUrl;
  final List<Link>? links;

  @JsonKey(name: 'next_page_url')
  final dynamic nextPageUrl;
  final String? path;

  @JsonKey(name: 'per_page')
  final int? perPage;

  @JsonKey(name: 'prev_page_url')
  final dynamic prevPageUrl;
  final int? to;
  final int? total;

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  @override
  List<Object?> get props => [
    currentPage,
    data,
    firstPageUrl,
    from,
    lastPage,
    lastPageUrl,
    links,
    nextPageUrl,
    path,
    perPage,
    prevPageUrl,
    to,
    total,
  ];
}

@JsonSerializable(createToJson: false)
class OrderModel extends Equatable {
  const OrderModel({
    required this.id,
    required this.qrCode,
    required this.caseType,
    required this.priority,
    required this.status,
    required this.orderType,
    required this.patientName,
    required this.serialNumber,
    required this.receivedAt,
    required this.deliveredAt,
    required this.remainingDays,
    required this.toothShadeName,
    required this.materialType,
    required this.price,
    required this.remainingAmount,
    required this.paidAmount,
    required this.orderTeethCount,
    required this.teeth,
    required this.files,
    required this.createdAt,
    required this.doctor,
    required this.lab,
    required this.currentDepartment,
  });

  final int? id;
  final Lab? lab;

  @JsonKey(name: 'qr_code')
  final String? qrCode;

  @JsonKey(name: 'case_type')
  final String? caseType;
  final String? priority;
  final String? status;

  @JsonKey(name: 'order_type')
  final String? orderType;

  @JsonKey(name: 'patient_name')
  final String? patientName;

  @JsonKey(name: 'serial_number')
  final String? serialNumber;

  @JsonKey(name: 'received_at')
  final DateTime? receivedAt;

  @JsonKey(name: 'delivered_at')
  final DateTime? deliveredAt;

  @JsonKey(name: 'remaining_days')
  final int? remainingDays;

  @JsonKey(name: 'tooth_shade_name')
  final String? toothShadeName;

  @JsonKey(name: 'material_type')
  final String? materialType;
  final String? price;

  @JsonKey(name: 'remaining_amount')
  final String? remainingAmount;

  @JsonKey(name: 'paid_amount')
  final String? paidAmount;

  @JsonKey(name: 'order_teeth_count')
  final int orderTeethCount;
  final List<int> teeth;
  final List<FileElement>? files;

  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  final Doctor doctor;

  @JsonKey(name: 'current_department')
  final Department? currentDepartment;

  List<WorkflowStep> get workflowSteps {
    final departments = lab?.departments ?? [];

    if (departments.isEmpty) {
      return [];
    }

    final currentDepartmentId = currentDepartment?.id;

    // نعتمد على ترتيب القائمة وليس قيمة الـ id
    final currentIndex = departments.indexWhere(
      (department) => department.id == currentDepartmentId,
    );

    // في حال لم نجد القسم الحالي
    if (currentIndex == -1) {
      return departments
          .map(
            (department) => WorkflowStep(
              title: department.name ?? '',
              progress: 0,
              isCurrent: false,
              status: null,
              hasStatus: false,
            ),
          )
          .toList();
    }

    final currentStatus = currentDepartment?.taskStatus;

    return List.generate(departments.length, (index) {
      final department = departments[index];

      // الأقسام المنتهية
      if (index < currentIndex) {
        return WorkflowStep(
          title: department.name ?? '',
          progress: 1,
          isCurrent: false,
          status: null,
          hasStatus: false,
        );
      }

      // القسم الحالي
      if (index == currentIndex) {
        return WorkflowStep(
          title: department.name ?? '',
          progress: _mapTaskStatusToProgress(currentStatus),
          isCurrent: true,
          status: currentStatus,
          hasStatus: currentStatus != null && currentStatus.isNotEmpty,
        );
      }

      // الأقسام القادمة
      return WorkflowStep(
        title: department.name ?? '',
        progress: 0,
        isCurrent: false,
        status: null,
        hasStatus: false,
      );
    });
  }

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  @override
  List<Object?> get props => [
    id,
    qrCode,
    caseType,
    priority,
    status,
    orderType,
    patientName,
    serialNumber,
    receivedAt,
    deliveredAt,
    remainingDays,
    toothShadeName,
    materialType,
    price,
    remainingAmount,
    paidAmount,
    orderTeethCount,
    teeth,
    files,
    createdAt,
    doctor,
    currentDepartment,
  ];
}

double _mapTaskStatusToProgress(String? status) {
  switch (status) {
    case 'assigned':
      return 0.0;

    case 'in_progress':
      return 0.50;

    case 'pending_review':
      return 0.75;

    case 'completed':
      return 1.0;

    default:
      return 0.0;
  }
}

@JsonSerializable(createToJson: false)
class Department extends Equatable {
  const Department({
    required this.id,
    required this.name,
    required this.description,
    required this.timeAllowed,
    required this.taskStatus,
    required this.isManagement,
  });

  final int? id;
  final String? name;
  final String? description;

  @JsonKey(name: 'time_allowed')
  final int? timeAllowed;

  @JsonKey(name: 'task_status')
  final String? taskStatus;

  @JsonKey(name: 'is_management')
  final bool? isManagement;

  factory Department.fromJson(Map<String, dynamic> json) =>
      _$DepartmentFromJson(json);

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    timeAllowed,
    taskStatus,
    isManagement,
  ];
}

@JsonSerializable(createToJson: false)
class Lab extends Equatable {
  const Lab({
    required this.id,
    required this.name,
    required this.phone,
    required this.address,
    required this.departments,
  });

  final int? id;
  final String? name;
  final String? phone;
  final String? address;
  final List<Department>? departments;

  factory Lab.fromJson(Map<String, dynamic> json) => _$LabFromJson(json);

  @override
  List<Object?> get props => [id, name, phone, address, departments];
}

@JsonSerializable(createToJson: false)
class Doctor extends Equatable {
  const Doctor({required this.id, required this.name, required this.location});

  final int id;
  final String name;
  final String location;

  factory Doctor.fromJson(Map<String, dynamic> json) => _$DoctorFromJson(json);

  @override
  List<Object?> get props => [id, name, location];
}

@JsonSerializable(createToJson: false)
class FileElement extends Equatable {
  const FileElement({
    required this.id,
    required this.filePath,
    required this.fileType,
    required this.uploadedAt,
  });

  final int? id;

  @JsonKey(name: 'file_path')
  final String? filePath;

  @JsonKey(name: 'file_type')
  final String? fileType;

  @JsonKey(name: 'uploaded_at')
  final DateTime? uploadedAt;

  factory FileElement.fromJson(Map<String, dynamic> json) =>
      _$FileElementFromJson(json);

  @override
  List<Object?> get props => [id, filePath, fileType, uploadedAt];
}

@JsonSerializable(createToJson: false)
class Link extends Equatable {
  const Link({
    required this.url,
    required this.label,
    required this.page,
    required this.active,
  });

  final String? url;
  final String? label;
  final int? page;
  final bool? active;

  factory Link.fromJson(Map<String, dynamic> json) => _$LinkFromJson(json);

  @override
  List<Object?> get props => [url, label, page, active];
}
