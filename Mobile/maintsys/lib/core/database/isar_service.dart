import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../../features/auth/domain/entities/app_user_entity.dart';
import '../../features/checklists/domain/entities/checklist_entity.dart';
import '../../features/checklists/domain/entities/checklist_item_entity.dart';
import '../../features/correctives/domain/entities/corrective_entity.dart';
import '../../features/inspections/domain/entities/inspection_entity.dart';
import '../../features/machines/domain/entities/machine_entity.dart';
import '../../features/notifications/domain/entities/notification_entity.dart';
import '../../features/occurrences/domain/entities/occurrence_entity.dart';
import '../../features/preventives/domain/entities/preventive_entity.dart';
import '../sync/sync_queue_entity.dart';

class IsarService {
  IsarService._();

  static final IsarService instance = IsarService._();

  Isar? _isar;

  bool get isOpen => _isar?.isOpen ?? false;

  Future<Isar> open() async {
    final current = _isar;
    if (current != null && current.isOpen) return current;

    final directory = await getApplicationDocumentsDirectory();
    final isar = await Isar.open(
      [
        AppUserEntitySchema,
        MachineEntitySchema,
        OccurrenceEntitySchema,
        InspectionEntitySchema,
        CorrectiveEntitySchema,
        PreventiveEntitySchema,
        ChecklistEntitySchema,
        ChecklistItemEntitySchema,
        SyncQueueEntitySchema,
        NotificationEntitySchema,
      ],
      directory: directory.path,
      name: 'maintsys',
    );
    _isar = isar;
    return isar;
  }

  Future<Isar> get database => open();

  Future<void> close() async {
    final current = _isar;
    if (current != null && current.isOpen) {
      await current.close();
    }
    _isar = null;
  }
}
