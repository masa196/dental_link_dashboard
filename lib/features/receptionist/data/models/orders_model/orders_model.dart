import 'package:dental_link_dashboard/features/receptionist/presentation/pages/receptionist_dashboard/order_card/workflow/models/workflow_step.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'orders_model.g.dart';

@JsonSerializable(createToJson: false)
class AllOrdersResponse extends Equatable {
   const  AllOrdersResponse({
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

    factory AllOrdersResponse.fromJson(Map<String, dynamic> json) => _$AllOrdersResponseFromJson(json);

    @override
    List<Object?> get props => [
    success, status, message, data, errors, ];
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
    currentPage, data, firstPageUrl, from, lastPage, lastPageUrl, links, nextPageUrl, path, perPage, prevPageUrl, to, total, ];
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
        required this.departments,
        required this.currentDepartment,
        required this.requiresResubmission,
        required this.resubmissionReason,
        required this.resubmissionRequestedAt,
        required this.qrPrintedAt,
        required this.createdAt,
        required this.doctor,
        required this.lab,
    });

    final int? id;

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
    final int? orderTeethCount;
    final List<int>? teeth;
    final List<FileElement>? files;
    final List<Department>? departments;

    @JsonKey(name: 'current_department') 
    final Department? currentDepartment;

    @JsonKey(name: 'requires_resubmission') 
    final bool? requiresResubmission;

    @JsonKey(name: 'resubmission_reason') 
    final dynamic resubmissionReason;

    @JsonKey(name: 'resubmission_requested_at') 
    final dynamic resubmissionRequestedAt;

     @JsonKey(name: 'qr_printed_at') 
    final DateTime? qrPrintedAt;

    @JsonKey(name: 'created_at') 
    final DateTime? createdAt;
    final Doctor? doctor;
    final Lab? lab;

    factory OrderModel.fromJson(Map<String, dynamic> json) => _$OrderModelFromJson(json);




/*
    List<WorkflowStep> get workflowSteps {
  final deps = departments ?? [];

  if (deps.isEmpty) {
    return [];
  }

  final currentIndex = deps.indexWhere((e) => e.isCurrent == true);

  if (currentIndex == -1) {
    return deps
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

  return List.generate(deps.length, (index) {
    final department = deps[index];

    // الأقسام السابقة
    if (index < currentIndex) {
      return WorkflowStep(
        title: department.name ?? '',
        progress: 1,
        isCurrent: false,
        status: 'completed',
        hasStatus: false,
      );
    }

    // القسم الحالي
    if (index == currentIndex) {
      return WorkflowStep(
        title: department.name ?? '',
        progress: _mapTaskStatusToProgress(department.status),
        isCurrent: true,
        status: department.status,
        hasStatus:
            department.status != null &&
            department.status!.isNotEmpty,
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
*/

List<WorkflowStep> get workflowSteps {
  final deps = departments ?? [];

  return deps.map((department) {
    final status = department.status;

    return WorkflowStep(
      title: department.name ?? '',
      progress: _mapTaskStatusToProgress(status),
      isCurrent: department.isCurrent == true,
      status: status,
      hasStatus: status != null && status.isNotEmpty,
    );
  }).toList();
}

double _mapTaskStatusToProgress(String? status) {
  switch (status) {
    case 'assigned':
    case 'pending_assignment':
      return 0.0;

    case 'in_progress':
      return 0.5;

    case 'pending_review':
      return 0.75;

    case 'completed':
      return 1.0;

    default:
      return 0.0;
  }
}

    @override
    List<Object?> get props => [
    id, qrCode, caseType, priority, status, orderType, patientName, serialNumber, receivedAt, deliveredAt, remainingDays, toothShadeName, materialType, price, remainingAmount, paidAmount, orderTeethCount, teeth, files, departments, currentDepartment, requiresResubmission, resubmissionReason, resubmissionRequestedAt, createdAt, doctor, lab, ];
}

@JsonSerializable(createToJson: false)
class Department extends Equatable {
  const  Department({
        required this.id,
        required this.name,
        required this.sortOrder,
        required this.taskId,
        required this.status,
        required this.approvedAt,
        required this.timeAllowedHours,
        required this.isManagement,
        required this.isCurrent,
    });

    final int? id;
    final String? name;

    @JsonKey(name: 'sort_order') 
    final int? sortOrder;

    @JsonKey(name: 'task_id') 
    final int? taskId;
    final String? status;

    @JsonKey(name: 'approved_at') 
    final DateTime? approvedAt;

    @JsonKey(name: 'time_allowed_hours') 
    final int? timeAllowedHours;

    @JsonKey(name: 'is_management') 
    final bool? isManagement;

    @JsonKey(name: 'is_current') 
    final bool? isCurrent;

    factory Department.fromJson(Map<String, dynamic> json) => _$DepartmentFromJson(json);

    @override
    List<Object?> get props => [
    id, name, sortOrder, taskId, status, approvedAt, timeAllowedHours, isManagement, isCurrent, ];
}

@JsonSerializable(createToJson: false)
class Doctor extends Equatable {
   const Doctor({
        required this.id,
        required this.name,
        required this.email,
        required this.phone,
        required this.location,
    });

    final int? id;
    final String? name;
    final String? email;
    final String? phone;
    final String? location;

    factory Doctor.fromJson(Map<String, dynamic> json) => _$DoctorFromJson(json);

    @override
    List<Object?> get props => [
    id, name, email, phone, location, ];
}

@JsonSerializable(createToJson: false)
class FileElement extends Equatable {
  const  FileElement({
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

    factory FileElement.fromJson(Map<String, dynamic> json) => _$FileElementFromJson(json);

    @override
    List<Object?> get props => [
    id, filePath, fileType, uploadedAt, ];
}

@JsonSerializable(createToJson: false)
class Lab extends Equatable {
 const  Lab({
        required this.id,
        required this.name,
        required this.phone,
        required this.address,
    });

    final int? id;
    final String? name;
    final String? phone;
    final String? address;

    factory Lab.fromJson(Map<String, dynamic> json) => _$LabFromJson(json);

    @override
    List<Object?> get props => [
    id, name, phone, address, ];
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
    List<Object?> get props => [
    url, label, page, active, ];




}
