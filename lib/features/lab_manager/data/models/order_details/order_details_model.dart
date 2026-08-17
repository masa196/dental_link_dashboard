
import 'package:dental_link_dashboard/features/lab_manager/presentation/pages/order_details/widgets/timeline/models/order_timeline_step.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_details_model.g.dart';

@JsonSerializable(createToJson: false)
class OrderDetailsResponse extends Equatable {
   const OrderDetailsResponse({
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

    factory OrderDetailsResponse.fromJson(Map<String, dynamic> json) => _$OrderDetailsResponseFromJson(json);

    @override
    List<Object?> get props => [
    success, status, message, data, errors, ];
}

@JsonSerializable(createToJson: false)
class Data extends Equatable {
  const Data({
    required this.orderdetails,
    required this.lock,
  });

  @JsonKey(name: 'order')
  final OrderDetails? orderdetails;

  final Lock? lock;

  factory Data.fromJson(Map<String, dynamic> json) =>
      _$DataFromJson(json);

  @override
  List<Object?> get props => [
        orderdetails,
        lock,
      ];
}
@JsonSerializable(createToJson: false)
class Lock extends Equatable {
   const Lock({
        required this.isLocked,
        required this.lockedBy,
        required this.lockedByName,
    });

    @JsonKey(name: 'is_locked') 
    final bool? isLocked;

    @JsonKey(name: 'locked_by') 
    final dynamic lockedBy;

    @JsonKey(name: 'locked_by_name') 
    final dynamic lockedByName;

    factory Lock.fromJson(Map<String, dynamic> json) => _$LockFromJson(json);

    @override
    List<Object?> get props => [
    isLocked, lockedBy, lockedByName, ];
}

@JsonSerializable(createToJson: false)
class  OrderDetails extends Equatable {
     const OrderDetails({
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
        required this.startDate,
        required this.endDate,
        required this.elapsedTime,
        required this.remainingTime,
        required this.estimatedTotalHours,
        required this.notes,
        required this.price,
        required this.remainingAmount,
        required this.paidAmount,
        required this.isPaid,
        required this.beforeImagePath,
        required this.afterImagePath,
        required this.requiresResubmission,
        required this.resubmissionReason,
        required this.resubmissionRequestedAt,
        required this.toothShadeName,
        required this.materialType,
        required this.caseName,
        required this.isPublished,
        required this.portfolioId,
        required this.createdAt,
        required this.updatedAt,
        required this.doctor,
        required this.lab,
        required this.teeth,
        required this.files,
        required this.tasks,
        required this.payments,
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

    @JsonKey(name: 'start_date') 
    final DateTime? startDate;

    @JsonKey(name: 'end_date') 
    final DateTime? endDate;

    @JsonKey(name: 'elapsed_time') 
    final ElapsedTime? elapsedTime;

    @JsonKey(name: 'remaining_time') 
    final RemainingTime? remainingTime;

    @JsonKey(name: 'estimated_total_hours') 
    final int? estimatedTotalHours;
    final String? notes;
    final String? price;

    @JsonKey(name: 'remaining_amount') 
    final String? remainingAmount;

    @JsonKey(name: 'paid_amount') 
    final String? paidAmount;

    @JsonKey(name: 'is_paid') 
    final bool? isPaid;

     @JsonKey(name: 'before_image_path') 
    final dynamic beforeImagePath;

    @JsonKey(name: 'after_image_path') 
    final dynamic afterImagePath;


    @JsonKey(name: 'requires_resubmission') 
    final bool? requiresResubmission;

    @JsonKey(name: 'resubmission_reason') 
    final dynamic resubmissionReason;

    @JsonKey(name: 'resubmission_requested_at') 
    final dynamic resubmissionRequestedAt;

     @JsonKey(name: 'tooth_shade_name') 
    final String? toothShadeName;

    @JsonKey(name: 'material_type') 
    final String? materialType;

    @JsonKey(name: 'case_name') 
    final dynamic caseName;

    @JsonKey(name: 'is_published') 
    final dynamic isPublished;

     @JsonKey(name: 'portfolio_id') 
    final int? portfolioId;


    @JsonKey(name: 'created_at') 
    final DateTime? createdAt;

    @JsonKey(name: 'updated_at') 
    final DateTime? updatedAt;
    final Doctor? doctor;
    final Lab? lab;
    final List<Tooth>? teeth;
    final List<FileElement>? files;
    final List<Task>? tasks;
    final List<dynamic>? payments;

    factory  OrderDetails.fromJson(Map<String, dynamic> json) => _$OrderDetailsFromJson(json);

List<OrderTimelineStep> get timelineSteps {
  final list = tasks ?? [];

  if (list.isEmpty) return [];

  return list.map((task) {
    final status = task.status;

    TimelineStatus timelineStatus;

    if (status == 'completed') {
      timelineStatus = TimelineStatus.completed;
    } else if (status == 'pending_assignment' ||
        status == 'assigned' ||
        status == 'in_progress' ||
        status == 'pending_review') {
      timelineStatus = TimelineStatus.current;
    } else {
      timelineStatus = TimelineStatus.pending;
    }

    return OrderTimelineStep(
      title: task.department?.name ?? '',
      employeeName: task.employee?.name ?? '',
      status: status,
      timelineStatus: timelineStatus,
      progress: _statusProgress(status),
    );
  }).toList();
}

double _statusProgress(String? status) {
  switch (status) {
    case 'pending_assignment':
      return .15;

    case 'assigned':
      return .25;

    case 'in_progress':
      return .5;

    case 'pending_review':
      return .75;

    case 'completed':
      return 1;

    default:
      return 0;
  }
}



    @override
    List<Object?> get props => [
    id, qrCode, caseType, priority, status, orderType, patientName, serialNumber, receivedAt, deliveredAt, startDate, endDate, elapsedTime, remainingTime, estimatedTotalHours, notes, price, remainingAmount, paidAmount, requiresResubmission, resubmissionReason, resubmissionRequestedAt, createdAt, updatedAt, doctor, lab, teeth, files, tasks, payments, ];
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
class ElapsedTime extends Equatable {
   const ElapsedTime({
        required this.minutes,
        required this.human,
    });

    final int? minutes;
    final String? human;

    factory ElapsedTime.fromJson(Map<String, dynamic> json) => _$ElapsedTimeFromJson(json);

    @override
    List<Object?> get props => [
    minutes, human, ];
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
class RemainingTime extends Equatable {
    const RemainingTime({
        required this.minutes,
        required this.human,
        required this.isOverdue,
    });

    final int? minutes;
    final String? human;

    @JsonKey(name: 'is_overdue') 
    final bool? isOverdue;

    factory RemainingTime.fromJson(Map<String, dynamic> json) => _$RemainingTimeFromJson(json);

    @override
    List<Object?> get props => [
    minutes, human, isOverdue, ];
}

@JsonSerializable(createToJson: false)
class Task extends Equatable {
   const Task({
        required this.id,
        required this.status,
        required this.approvedAt,
        required this.department,
        required this.employee,
    });

    final int? id;
    final String? status;

    @JsonKey(name: 'approved_at') 
    final dynamic approvedAt;
    final Department? department;
    final Employee? employee;

    factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

    @override
    List<Object?> get props => [
    id, status, approvedAt, department, employee, ];
}

@JsonSerializable(createToJson: false)
class Department extends Equatable {
   const Department({
        required this.id,
        required this.name,
    });

    final int? id;
    final String? name;

    factory Department.fromJson(Map<String, dynamic> json) => _$DepartmentFromJson(json);

    @override
    List<Object?> get props => [
    id, name, ];
}

@JsonSerializable(createToJson: false)
class Employee extends Equatable {
    const Employee({
        required this.id,
        required this.name,
        required this.email,
    });

    final int? id;
    final String? name;
    final String? email;

    factory Employee.fromJson(Map<String, dynamic> json) => _$EmployeeFromJson(json);

    @override
    List<Object?> get props => [
    id, name, email, ];
}

@JsonSerializable(createToJson: false)
class Tooth extends Equatable {
const  Tooth({
        required this.id,
        required this.orderId,
        required this.toothNumber,
        required this.notes,
    });

    final int? id;

    @JsonKey(name: 'order_id') 
    final int? orderId;

    @JsonKey(name: 'tooth_number') 
    final int? toothNumber;
    final String? notes;

    factory Tooth.fromJson(Map<String, dynamic> json) => _$ToothFromJson(json);

    @override
    List<Object?> get props => [
    id, orderId, toothNumber, notes, ];
}
