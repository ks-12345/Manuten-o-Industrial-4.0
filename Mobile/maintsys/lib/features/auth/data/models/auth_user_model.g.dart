// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AuthUserModelImpl _$$AuthUserModelImplFromJson(Map<String, dynamic> json) =>
    _$AuthUserModelImpl(
      id: json['id'] as String,
      email: json['email'] as String,
      role: $enumDecode(_$AppUserRoleEnumMap, json['role']),
      sectorId: json['sectorId'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$AuthUserModelImplToJson(_$AuthUserModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'role': _$AppUserRoleEnumMap[instance.role]!,
      'sectorId': instance.sectorId,
      'createdAt': instance.createdAt.toIso8601String(),
    };

const _$AppUserRoleEnumMap = {
  AppUserRole.admin: 'admin',
  AppUserRole.supervisor: 'supervisor',
  AppUserRole.technician: 'technician',
};
