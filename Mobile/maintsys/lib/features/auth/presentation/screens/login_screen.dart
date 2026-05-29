import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_router.dart';
import '../../../../shared/constants/app_colors.dart';
import '../../../../shared/widgets/error_view.dart';
import '../../../../shared/widgets/industrial_card.dart';
import '../../../../shared/widgets/loading_overlay.dart';
import '../providers/auth_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  static const route = '/login';

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(authProvider, (previous, next) {
      next.whenOrNull(
        data: (state) {
          if (state.isAuthenticated) context.go(AppRoutes.dashboard);
        },
      );
    });

    final auth = ref.watch(authProvider);

    return Scaffold(
      body: SafeArea(
        child: LoadingOverlay(
          isLoading: auth.isLoading,
          label: 'Autenticando operador',
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 440),
                child: IndustrialCard(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Icon(
                          Icons.verified_user_outlined,
                          color: Theme.of(context).colorScheme.primary,
                          size: 56,
                        ),
                        const SizedBox(height: 18),
                        Text(
                          'Acesso operacional',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(fontWeight: FontWeight.w900),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Entre com sua conta Supabase ou use modo demo offline.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.68),
                          ),
                        ),
                        const SizedBox(height: 24),
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            labelText: 'E-mail',
                            prefixIcon: Icon(Icons.mail_outline),
                          ),
                          validator: (value) {
                            final text = value?.trim() ?? '';
                            if (text.isEmpty || !text.contains('@')) {
                              return 'Informe um e-mail valido.';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: _obscurePassword,
                          decoration: InputDecoration(
                            labelText: 'Senha',
                            prefixIcon: const Icon(Icons.lock_outline),
                            suffixIcon: IconButton(
                              tooltip: _obscurePassword
                                  ? 'Mostrar senha'
                                  : 'Ocultar senha',
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if ((value ?? '').isEmpty) {
                              return 'Informe a senha.';
                            }
                            return null;
                          },
                          onFieldSubmitted: (_) => _submit(),
                        ),
                        const SizedBox(height: 18),
                        FilledButton.icon(
                          onPressed: auth.isLoading ? null : _submit,
                          icon: const Icon(Icons.login),
                          label: const Text('Entrar'),
                        ),
                        const SizedBox(height: 10),
                        OutlinedButton.icon(
                          onPressed: auth.isLoading
                              ? null
                              : () => ref
                                    .read(authProvider.notifier)
                                    .signInWithBiometrics(),
                          icon: const Icon(Icons.fingerprint),
                          label: const Text('Biometria'),
                        ),
                        const SizedBox(height: 14),
                        auth.when(
                          loading: () => const SizedBox.shrink(),
                          data: (_) => const SizedBox.shrink(),
                          error: (error, stackTrace) => ErrorView(
                            message: error.toString(),
                            onRetry: () =>
                                ref.read(authProvider.notifier).bootstrap(),
                            dense: true,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const _DemoCredentialsHint(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    ref
        .read(authProvider.notifier)
        .signIn(
          email: _emailController.text,
          password: _passwordController.text,
        );
  }
}

class _DemoCredentialsHint extends StatelessWidget {
  const _DemoCredentialsHint();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.22)),
      ),
      child: Text(
        'Demo offline: admin@maintsys.local, supervisor@maintsys.local ou tecnico@maintsys.local com qualquer senha.',
        style: Theme.of(context).textTheme.bodySmall,
      ),
    );
  }
}
