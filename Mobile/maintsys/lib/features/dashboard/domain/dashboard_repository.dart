import '../../../core/models/industrial_models.dart';

abstract interface class DashboardRepository {
  Future<DashboardSnapshot> getSnapshot();
}
