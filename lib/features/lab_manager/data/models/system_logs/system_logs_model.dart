import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'system_logs_model.g.dart';

@JsonSerializable(createToJson: false)
class SystemLogsResponse extends Equatable {
  const   SystemLogsResponse({
        required this.success,
        required this.status,
        required this.message,
        required this.data,
        required this.errors,
    });

    final bool? success;
    final int? status;
    final String? message;
    final List<SystemLogItem>? data;
    final dynamic errors;

    factory SystemLogsResponse.fromJson(Map<String, dynamic> json) => _$SystemLogsResponseFromJson(json);

    @override
    List<Object?> get props => [
    success, status, message, data, errors, ];
}

@JsonSerializable(createToJson: false)
class SystemLogItem extends Equatable {
   const SystemLogItem({
        required this.id,
        required this.level,
        required this.event,
        required this.message,
        required this.user,
        required this.labId,
        required this.metadata,
        required this.createdAt,
    });

    final int? id;
    final String? level;
    final String? event;
    final String? message;
    final UserInsSystemLogs? user;

    @JsonKey(name: 'lab_id') 
    final int? labId;
    final Metadata? metadata;

    @JsonKey(name: 'created_at') 
    final DateTime? createdAt;

    factory SystemLogItem.fromJson(Map<String, dynamic> json) => _$SystemLogItemFromJson(json);

    @override
    List<Object?> get props => [
    id, level, event, message, user, labId, metadata, createdAt, ];
}

@JsonSerializable(createToJson: false)
class Metadata extends Equatable {
    const Metadata({
        required this.email,
    });

    final String? email;

    factory Metadata.fromJson(Map<String, dynamic> json) => _$MetadataFromJson(json);

    @override
    List<Object?> get props => [
    email, ];
}

@JsonSerializable(createToJson: false)
class UserInsSystemLogs extends Equatable {
    const UserInsSystemLogs({
        required this.id,
        required this.name,
    });

    final int? id;
    final String? name;

    factory UserInsSystemLogs.fromJson(Map<String, dynamic> json) => _$UserInsSystemLogsFromJson(json);

    @override
    List<Object?> get props => [
    id, name, ];
}
