import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'core/database/isar_service.dart';
import 'core/supabase/supabase_service.dart';
import 'core/sync/workmanager_sync.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SupabaseService.instance.initialize();
  await IsarService.instance.open();
  await initializeBackgroundSync();
  runApp(const ProviderScope(child: MaintSysApp()));
}
