import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maintsys/app.dart';
import 'package:maintsys/features/auth/data/models/auth_user_model.dart';
import 'package:maintsys/features/auth/domain/repositories/auth_repository.dart';
import 'package:maintsys/features/auth/presentation/providers/auth_provider.dart';

void main() {
  testWidgets('MaintSys app redirects unauthenticated user to login', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authProvider.overrideWith(
            (ref) => _TestAuthNotifier(const AuthState()),
          ),
        ],
        child: const MaintSysApp(),
      ),
    );

    expect(find.text('MaintSys'), findsOneWidget);
    expect(find.text('Manutencao Industrial 4.0'), findsOneWidget);

    await tester.pumpAndSettle();

    expect(find.text('Acesso operacional'), findsOneWidget);
  });
}

class _TestAuthNotifier extends AuthNotifier {
  _TestAuthNotifier(AuthState value) : super(_TestAuthRepository()) {
    state = AsyncValue.data(value);
  }
}

class _TestAuthRepository implements AuthRepository {
  @override
  Future<AuthUserModel?> currentUser() async => null;

  @override
  Future<AuthUserModel> signIn({
    required String email,
    required String password,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<AuthUserModel> signInWithBiometrics() {
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() async {}
}
