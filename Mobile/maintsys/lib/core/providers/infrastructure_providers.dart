import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../services/connectivity_service.dart';
import '../../services/local_database_service.dart';

final connectivityServiceProvider = Provider<ConnectivityService>((ref) {
  return ConnectivityPlusService(Connectivity());
});

final onlineStatusProvider = StreamProvider<bool>((ref) {
  return ref.watch(connectivityServiceProvider).watchOnline();
});

final localDatabaseServiceProvider = Provider<LocalDatabaseService>((ref) {
  return IsarLocalDatabaseService();
});
