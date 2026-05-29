import 'package:isar/isar.dart';

import '../../../../shared/constants/status_enum.dart';

part 'app_user_entity.g.dart';

@collection
class AppUserEntity {
  AppUserEntity({
    this.localId = Isar.autoIncrement,
    required this.remoteId,
    required this.email,
    required this.role,
    this.sectorRemoteId,
    required this.createdAt,
    this.syncStatus = SyncStatus.synced,
  });

  Id localId;

  @Index(unique: true, replace: true)
  String remoteId;

  @Index(unique: true, replace: true)
  String email;

  @enumerated
  AppUserRole role;

  String? sectorRemoteId;
  DateTime createdAt;
  DateTime updatedAt = DateTime.now();

  @enumerated
  SyncStatus syncStatus;
}
