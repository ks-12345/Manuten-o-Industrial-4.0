import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:local_auth/local_auth.dart';

import '../../../../core/database/isar_service.dart';
import '../../../../core/supabase/supabase_service.dart';
import '../../../../shared/constants/status_enum.dart';
import '../../data/datasources/auth_local_datasource.dart';
import '../../data/datasources/auth_remote_datasource.dart';
import '../../data/models/auth_user_model.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';

part 'auth_provider.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    AuthUserModel? user,
    @Default(false) bool isSyncing,
    String? error,
  }) = _AuthState;
}

extension AuthStateX on AuthState {
  bool get isAuthenticated => user != null;

  AppUserRole? get role => user?.role;
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(
    remoteDataSource: AuthRemoteDataSource(SupabaseService.instance),
    localDataSource: AuthLocalDataSource(
      isarService: IsarService.instance,
      secureStorage: const FlutterSecureStorage(),
    ),
    localAuthentication: LocalAuthentication(),
  );
});

final authProvider = StateNotifierProvider<AuthNotifier, AsyncValue<AuthState>>(
  (ref) {
    return AuthNotifier(ref.watch(authRepositoryProvider));
  },
);

class AuthNotifier extends StateNotifier<AsyncValue<AuthState>> {
  AuthNotifier(this._repository)
    : super(const AsyncValue.data(AuthState(isSyncing: true))) {
    bootstrap();
  }

  final AuthRepository _repository;

  Future<void> bootstrap() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final user = await _repository.currentUser();
      return AuthState(user: user);
    });
  }

  Future<void> signIn({required String email, required String password}) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final user = await _repository.signIn(email: email, password: password);
      return AuthState(user: user);
    });
  }

  Future<void> signInWithBiometrics() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final user = await _repository.signInWithBiometrics();
      return AuthState(user: user);
    });
  }

  Future<void> signOut() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _repository.signOut();
      return const AuthState();
    });
  }
}
