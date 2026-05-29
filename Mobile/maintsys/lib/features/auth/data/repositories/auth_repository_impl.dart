import 'package:local_auth/local_auth.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/error/app_exception.dart';
import '../../../../shared/constants/status_enum.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_datasource.dart';
import '../datasources/auth_remote_datasource.dart';
import '../models/auth_user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required AuthRemoteDataSource remoteDataSource,
    required AuthLocalDataSource localDataSource,
    required LocalAuthentication localAuthentication,
  }) : _remoteDataSource = remoteDataSource,
       _localDataSource = localDataSource,
       _localAuthentication = localAuthentication;

  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;
  final LocalAuthentication _localAuthentication;

  @override
  Future<AuthUserModel?> currentUser() async {
    final remoteUser = await _remoteDataSource.currentUser();
    if (remoteUser != null) {
      await _localDataSource.saveSession(remoteUser);
      return remoteUser;
    }
    return _localDataSource.readSession();
  }

  @override
  Future<AuthUserModel> signIn({
    required String email,
    required String password,
  }) async {
    final sanitizedEmail = email.trim().toLowerCase();
    if (sanitizedEmail.isEmpty || password.isEmpty) {
      throw const AuthException(
        'Informe e-mail e senha para acessar o MaintSys.',
        code: 'empty_credentials',
      );
    }

    AuthUserModel user;
    if (_remoteDataSource.isConfigured) {
      user = await _remoteDataSource.signIn(
        email: sanitizedEmail,
        password: password,
      );
    } else {
      user = _demoUser(sanitizedEmail);
    }

    await _localDataSource.saveSession(user);
    return user;
  }

  @override
  Future<AuthUserModel> signInWithBiometrics() async {
    final cached = await _localDataSource.readSession();
    if (cached == null) {
      throw const AuthException(
        'Entre com e-mail e senha antes de habilitar biometria.',
        code: 'biometry_without_session',
      );
    }

    final available =
        await _localAuthentication.canCheckBiometrics ||
        await _localAuthentication.isDeviceSupported();
    if (!available) {
      throw const AuthException(
        'Biometria indisponivel neste dispositivo.',
        code: 'biometry_unavailable',
      );
    }

    final authenticated = await _localAuthentication.authenticate(
      localizedReason: 'Autentique-se para acessar o MaintSys Mobile',
      biometricOnly: false,
      persistAcrossBackgrounding: true,
    );
    if (!authenticated) {
      throw const AuthException(
        'Autenticacao biometrica cancelada.',
        code: 'biometry_cancelled',
      );
    }
    return cached;
  }

  @override
  Future<void> signOut() async {
    await _remoteDataSource.signOut();
    await _localDataSource.clearSession();
  }

  AuthUserModel _demoUser(String email) {
    final role = email.startsWith('admin')
        ? AppUserRole.admin
        : email.startsWith('supervisor')
        ? AppUserRole.supervisor
        : AppUserRole.technician;
    return AuthUserModel(
      id: const Uuid().v5(Namespace.url.value, email),
      email: email,
      role: role,
      sectorId: role == AppUserRole.admin ? null : 'demo-sector',
      createdAt: DateTime.now(),
    );
  }
}
