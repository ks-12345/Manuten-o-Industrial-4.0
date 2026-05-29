import '../../data/models/auth_user_model.dart';

abstract interface class AuthRepository {
  Future<AuthUserModel?> currentUser();

  Future<AuthUserModel> signIn({
    required String email,
    required String password,
  });

  Future<AuthUserModel> signInWithBiometrics();

  Future<void> signOut();
}
