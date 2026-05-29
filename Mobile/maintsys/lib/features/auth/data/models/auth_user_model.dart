import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../shared/constants/status_enum.dart';

part 'auth_user_model.freezed.dart';
part 'auth_user_model.g.dart';

@freezed
class AuthUserModel with _$AuthUserModel {
  const factory AuthUserModel({
    required String id,
    required String email,
    required AppUserRole role,
    String? sectorId,
    required DateTime createdAt,
  }) = _AuthUserModel;

  factory AuthUserModel.fromJson(Map<String, dynamic> json) =>
      _$AuthUserModelFromJson(json);
}
