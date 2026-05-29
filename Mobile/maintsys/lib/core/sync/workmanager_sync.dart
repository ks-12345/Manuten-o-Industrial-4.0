import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/widgets.dart';
import 'package:workmanager/workmanager.dart';

import '../database/isar_service.dart';
import '../network/connectivity_service.dart';
import '../supabase/supabase_service.dart';
import 'sync_manager.dart';

const maintsysPeriodicSyncTask = 'maintsys_periodic_sync';

@pragma('vm:entry-point')
void maintsysWorkmanagerDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    WidgetsFlutterBinding.ensureInitialized();
    await SupabaseService.instance.initialize();
    await IsarService.instance.open();
    final manager = SyncManager(
      isarService: IsarService.instance,
      supabaseService: SupabaseService.instance,
      connectivityService: ConnectivityService(Connectivity()),
    );
    await manager.processQueue();
    return true;
  });
}

Future<void> initializeBackgroundSync() async {
  await Workmanager().initialize(maintsysWorkmanagerDispatcher);
  await Workmanager().registerPeriodicTask(
    maintsysPeriodicSyncTask,
    maintsysPeriodicSyncTask,
    frequency: const Duration(minutes: 15),
    existingWorkPolicy: ExistingPeriodicWorkPolicy.keep,
    constraints: Constraints(networkType: NetworkType.connected),
  );
}
