import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/models/industrial_models.dart';
import '../data/mock_dashboard_repository.dart';
import '../domain/dashboard_repository.dart';

final dashboardRepositoryProvider = Provider<DashboardRepository>((ref) {
  return MockDashboardRepository();
});

final dashboardSnapshotProvider = FutureProvider<DashboardSnapshot>((ref) {
  return ref.watch(dashboardRepositoryProvider).getSnapshot();
});
