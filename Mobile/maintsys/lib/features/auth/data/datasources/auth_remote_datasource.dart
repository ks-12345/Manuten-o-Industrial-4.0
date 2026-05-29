import 'package:supabase_flutter/supabase_flutter.dart' hide AuthException;

import '../../../../core/error/app_exception.dart';
import '../../../../core/supabase/supabase_service.dart';
import '../../../../shared/constants/status_enum.dart';
import '../models/auth_user_model.dart';

class AuthRemoteDataSource {
  AuthRemoteDataSource(this._supabaseService);

  final SupabaseService _supabaseService;

  bool get isConfigured => _supabaseService.isConfigured;

  User? get currentSupabaseUser =>
      _supabaseService.maybeClient?.auth.currentUser;

  Future<AuthUserModel?> currentUser() async {
    final client = _supabaseService.maybeClient;
    final user = client?.auth.currentUser;
    if (client == null || user == null) return null;

    final profile = await client
        .from('users')
        .select('id,email,role,sector_id,created_at')
        .eq('id', user.id)
        .maybeSingle();

    return _fromProfile(profile, user);
  }

  Future<AuthUserModel> signIn({
    required String email,
    required String password,
  }) async {
    final client = _supabaseService.maybeClient;
    if (client == null) {
      throw const AuthException(
        'Supabase nao configurado para autenticacao remota.',
        code: 'supabase_not_configured',
      );
    }

    final response = await client.auth.signInWithPassword(
      email: email.trim(),
      password: password,
    );
    final user = response.user;
    if (user == null) {
      throw const AuthException(
        'Credenciais invalidas.',
        code: 'invalid_login',
      );
    }

    final profile = await client
        .from('users')
        .select('id,email,role,sector_id,created_at')
        .eq('id', user.id)
        .maybeSingle();

    return _fromProfile(profile, user);
  }

  Future<void> signOut() async {
    final client = _supabaseService.maybeClient;
    if (client != null) await client.auth.signOut();
  }

  AuthUserModel _fromProfile(Map<String, dynamic>? profile, User user) {
    final createdAt = profile?['created_at']?.toString() ?? user.createdAt;
    return AuthUserModel(
      id: profile?['id']?.toString() ?? user.id,
      email: profile?['email']?.toString() ?? user.email ?? '',
      role: AppUserRoleX.fromRemote(profile?['role']?.toString()),
      sectorId: profile?['sector_id']?.toString(),
      createdAt: DateTime.tryParse(createdAt) ?? DateTime.now(),
    );
  }
}
