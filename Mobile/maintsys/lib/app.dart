import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/router/app_router.dart';
import 'core/sync/sync_manager.dart';
import 'core/theme/app_theme.dart';

class MaintSysApp extends ConsumerWidget {
  const MaintSysApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(syncBootstrapProvider);
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'MaintSys Mobile',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkIndustrial(),
      routerConfig: router,
    );
  }
}
