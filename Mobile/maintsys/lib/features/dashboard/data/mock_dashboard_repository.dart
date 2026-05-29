import '../../../core/enums/maintenance_enums.dart';
import '../../../core/models/industrial_models.dart';
import '../domain/dashboard_repository.dart';

class MockDashboardRepository implements DashboardRepository {
  @override
  Future<DashboardSnapshot> getSnapshot() async {
    await Future<void>.delayed(const Duration(milliseconds: 350));
    final now = DateTime.now();

    return DashboardSnapshot(
      metrics: const [
        IndustrialMetric(
          label: 'Maquinas ativas',
          value: '18',
          trend: '+4% semana',
          status: MachineStatus.running,
        ),
        IndustrialMetric(
          label: 'Maquinas paradas',
          value: '03',
          trend: '2 criticas',
          status: MachineStatus.broken,
        ),
        IndustrialMetric(
          label: 'Corretivas abertas',
          value: '07',
          trend: 'MTTR 2.8h',
          status: MachineStatus.maintenance,
        ),
        IndustrialMetric(
          label: 'Preventivas atrasadas',
          value: '02',
          trend: 'acao hoje',
          status: MachineStatus.attention,
        ),
      ],
      machines: [
        MachineSummary(
          id: 'm-001',
          code: 'CNC-01',
          name: 'Centro de Usinagem CNC',
          sector: 'Usinagem',
          status: MachineStatus.running,
          lastUpdate: now.subtract(const Duration(minutes: 8)),
          mtbfHours: 126,
          mttrHours: 1.7,
        ),
        MachineSummary(
          id: 'm-002',
          code: 'CLP-04',
          name: 'Bancada CLP Didatica',
          sector: 'Automacao',
          status: MachineStatus.attention,
          lastUpdate: now.subtract(const Duration(minutes: 22)),
          mtbfHours: 88,
          mttrHours: 2.1,
        ),
        MachineSummary(
          id: 'm-003',
          code: 'PRE-02',
          name: 'Prensa Hidraulica',
          sector: 'Conformacao',
          status: MachineStatus.broken,
          lastUpdate: now.subtract(const Duration(hours: 1, minutes: 14)),
          mtbfHours: 63,
          mttrHours: 4.6,
        ),
        MachineSummary(
          id: 'm-004',
          code: 'ROB-01',
          name: 'Celula Robotizada',
          sector: 'Robotica',
          status: MachineStatus.maintenance,
          lastUpdate: now.subtract(const Duration(minutes: 41)),
          mtbfHours: 142,
          mttrHours: 2.9,
        ),
      ],
      occurrences: [
        OccurrenceSummary(
          id: 'o-101',
          machineCode: 'PRE-02',
          sector: 'Conformacao',
          description: 'Vazamento no circuito hidraulico principal.',
          priority: PriorityLevel.critical,
          status: OccurrenceStatus.inMaintenance,
          createdAt: now.subtract(const Duration(hours: 3)),
          syncStatus: SyncStatus.pending,
        ),
        OccurrenceSummary(
          id: 'o-102',
          machineCode: 'CLP-04',
          sector: 'Automacao',
          description: 'Falha intermitente em sensor indutivo.',
          priority: PriorityLevel.high,
          status: OccurrenceStatus.underAnalysis,
          createdAt: now.subtract(const Duration(hours: 5)),
          syncStatus: SyncStatus.synced,
        ),
        OccurrenceSummary(
          id: 'o-103',
          machineCode: 'ROB-01',
          sector: 'Robotica',
          description: 'Preventiva em eixo 3 com checklist pendente.',
          priority: PriorityLevel.medium,
          status: OccurrenceStatus.open,
          createdAt: now.subtract(const Duration(hours: 8)),
          syncStatus: SyncStatus.error,
        ),
      ],
      syncQueue: [
        SyncQueueItem(
          localId: 'queue-001',
          recordType: 'corrective_order',
          createdAt: now.subtract(const Duration(minutes: 18)),
          status: SyncStatus.pending,
          attempts: 0,
        ),
        SyncQueueItem(
          localId: 'queue-002',
          recordType: 'inspection_photo',
          createdAt: now.subtract(const Duration(minutes: 44)),
          status: SyncStatus.error,
          attempts: 2,
        ),
        SyncQueueItem(
          localId: 'queue-003',
          recordType: 'checklist_answer',
          createdAt: now.subtract(const Duration(hours: 1)),
          status: SyncStatus.synced,
          attempts: 1,
          syncedAt: now.subtract(const Duration(minutes: 35)),
        ),
      ],
    );
  }
}
