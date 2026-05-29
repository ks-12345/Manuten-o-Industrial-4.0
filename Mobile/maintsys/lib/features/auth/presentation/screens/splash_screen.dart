import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_router.dart';
import '../../../../shared/constants/app_colors.dart';
import '../../../../shared/constants/status_enum.dart';
import '../../../../shared/widgets/industrial_loading_widget.dart';
import '../providers/auth_provider.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  static const route = '/splash';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider);

    ref.listen(authProvider, (previous, next) {
      next.whenOrNull(
        data: (state) {
          final role = state.role;
          if (role == null) {
            context.go(AppRoutes.login);
            return;
          }
          final target = switch (role) {
            AppUserRole.admin => AppRoutes.dashboard,
            AppUserRole.supervisor => AppRoutes.occurrences,
            AppUserRole.technician => AppRoutes.occurrences,
          };
          context.go(target);
        },
        error: (_, _) => context.go(AppRoutes.login),
      );
    });

    auth.whenOrNull(
      data: (state) => WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!context.mounted) return;
        final role = state.role;
        if (role == null) {
          context.go(AppRoutes.login);
          return;
        }
        final target = switch (role) {
          AppUserRole.admin => AppRoutes.dashboard,
          AppUserRole.supervisor => AppRoutes.occurrences,
          AppUserRole.technician => AppRoutes.occurrences,
        };
        context.go(target);
      }),
      error: (_, _) => WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) context.go(AppRoutes.login);
      }),
    );

    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.precision_manufacturing,
              size: 72,
              color: AppColors.primary,
            ),
            SizedBox(height: 18),
            Text(
              'MaintSys',
              style: TextStyle(fontSize: 34, fontWeight: FontWeight.w900),
            ),
            SizedBox(height: 6),
            Text('Manutencao Industrial 4.0'),
            SizedBox(height: 28),
            IndustrialLoadingWidget(label: 'Validando sessao segura'),
          ],
        ),
      ),
    );
  }
}
