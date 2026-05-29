import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../../core/database/isar_service.dart';
import '../../../../shared/constants/status_enum.dart';
import '../../domain/entities/app_user_entity.dart';
import '../models/auth_user_model.dart';

class AuthLocalDataSource {
  AuthLocalDataSource({
    required IsarService isarService,
    required FlutterSecureStorage secureStorage,
  }) : _isarService = isarService,
       _secureStorage = secureStorage;

  static const _sessionKey = 'maintsys.auth.user';

  final IsarService _isarService;
  final FlutterSecureStorage _secureStorage;

  Future<AuthUserModel?> readSession() async {
    final raw = await _secureStorage.read(key: _sessionKey);
    if (raw == null) return null;
    return AuthUserModel.fromJson(jsonDecode(raw) as Map<String, dynamic>);
  }

  Future<void> saveSession(AuthUserModel user) async {
    await _secureStorage.write(key: _sessionKey, value: jsonEncode(user));
    final isar = await _isarService.database;
    final entity = AppUserEntity(
      remoteId: user.id,
      email: user.email,
      role: user.role,
      sectorRemoteId: user.sectorId,
      createdAt: user.createdAt,
      syncStatus: SyncStatus.synced,
    );
    await isar.writeTxn(() => isar.appUserEntitys.putByEmail(entity));
  }

  Future<void> clearSession() async {
    await _secureStorage.delete(key: _sessionKey);
  }
}
