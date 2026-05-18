import 'package:isar/isar.dart';

part 'machine_model.g.dart';

enum MachineStatus { active, attention, broken, maintenance }

@collection
class MachineModel {
  Id id = Isar.autoIncrement;

  late String name;
  late String model;
  late String patrimony;
  late String voltage;
  late String? description;
  late int sectorId;

  @Enumerated(EnumType.name)
  late MachineStatus status;

  late DateTime installationDate;
  DateTime? lastPreventive;
  DateTime? nextPreventive;
  DateTime? lastCorrective;

  // QR Code identifier
  late String qrCode;

  DateTime createdAt = DateTime.now();
  DateTime updatedAt = DateTime.now();
}

@collection
class SectorModel {
  Id id = Isar.autoIncrement;
  late String name;
  late String description;
  DateTime createdAt = DateTime.now();
}