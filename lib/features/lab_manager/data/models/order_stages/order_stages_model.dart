import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_stages_model.g.dart';

@JsonSerializable(createToJson: false)
class OrderStagesResponse extends Equatable {
  const  OrderStagesResponse({
        required this.success,
        required this.status,
        required this.message,
        required this.data,
        required this.errors,
    });

    final bool? success;
    final int? status;
    final String? message;
    final OrderStagesData? data;
    final dynamic errors;

    factory OrderStagesResponse.fromJson(Map<String, dynamic> json) => _$OrderStagesResponseFromJson(json);

    @override
    List<Object?> get props => [
    success, status, message, data, errors, ];
}

@JsonSerializable(createToJson: false)
class OrderStagesData extends Equatable {
    const OrderStagesData({
        required this.labId,
        required this.totalDepartments,
        required this.totalEstimatedTimeHours,
        required this.departments,
    });

    @JsonKey(name: 'lab_id') 
    final int? labId;

    @JsonKey(name: 'total_departments') 
    final int? totalDepartments;

    @JsonKey(name: 'total_estimated_time_hours') 
    final int? totalEstimatedTimeHours;
    final List<OrderStageDepartment>? departments;

    factory OrderStagesData.fromJson(Map<String, dynamic> json) => _$OrderStagesDataFromJson(json);

    @override
    List<Object?> get props => [
    labId, totalDepartments, totalEstimatedTimeHours, departments, ];
}

@JsonSerializable(createToJson: false)
class OrderStageDepartment extends Equatable {
    const OrderStageDepartment({
        required this.id,
        required this.name,
        required this.sortOrder,
        required this.timeAllowedHours,
        required this.inOrderWorkflow,
    });

    final int? id;
    final String? name;

    @JsonKey(name: 'sort_order') 
    final int? sortOrder;

    @JsonKey(name: 'time_allowed_hours') 
    final int? timeAllowedHours;

    @JsonKey(name: 'in_order_workflow') 
    final bool? inOrderWorkflow;

    factory OrderStageDepartment.fromJson(Map<String, dynamic> json) => _$OrderStageDepartmentFromJson(json);

    @override
    List<Object?> get props => [
    id, name, sortOrder, timeAllowedHours, inOrderWorkflow, ];
}
