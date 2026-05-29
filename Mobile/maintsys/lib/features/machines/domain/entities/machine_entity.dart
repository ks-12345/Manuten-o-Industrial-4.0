import 'package:isar/isar.dart';

import '../../../../shared/constants/status_enum.dart';

part 'machine_entity.g.dart';

@collection
class MachineEntity {
  MachineEntity({
    this.localId = Isar.autoIncrement,
    this.remoteId,
    required this.code,
    required this.name,
    required this.sectorName,
    this.sectorRemoteId,
    this.model,
    this.manufacturer,
    this.lastMaintenance,
    this.status = MachineOperationalStatus.operating,
    this.syncStatus = SyncStatus.pending,
  });

  Id localId;

  @Index(unique: true, replace: true)
  String? remoteId;

  @Index()
  String code;

  String name;
  String sectorName;
  String? sectorRemoteId;
  String? model;
  String? manufacturer;
  DateTime? lastMaintenance;
  DateTime createdAt = DateTime.now();
  DateTime updatedAt = DateTime.now();

  @enumerated
  MachineOperationalStatus status;

  @enumerated
  SyncStatus syncStatus;
}
