// import 'package:isar/isar.dart';

// part 'machine_model.g.dart';

// enum MachineStatus { active, attention, broken, maintenance }

// @collection
// class MachineModel {
//   Id id = Isar.autoIncrement;

//   late String name;
//   late String model;
//   late String patrimony;
//   late String voltage;
//   late String? description;
//   late int sectorId;

//   @Enumerated(EnumType.name)
//   late MachineStatus status;

//   late DateTime installationDate;
//   DateTime? lastPreventive;
//   DateTime? nextPreventive;
//   DateTime? lastCorrective;

//   // QR Code identifier
//   late String qrCode;

//   DateTime createdAt = DateTime.now();
//   DateTime updatedAt = DateTime.now();
// }

// @collection
// class SectorModel {
//   Id id = Isar.autoIncrement;
//   late String name;
//   // late String description;
//   String description = '';
//   DateTime createdAt = DateTime.now();
// }

import 'package:isar/isar.dart';

part 'machine_model.g.dart';

enum MachineStatus { active, attention, broken, maintenance }

@collection
class MachineModel {
  Id id = Isar.autoIncrement;

  String name = '';

  String model = '';

  String patrimony = '';

  String voltage = '';

  String? description;

  int sectorId = 0;

  @Enumerated(EnumType.name)
  MachineStatus status = MachineStatus.active;

  DateTime installationDate = DateTime.now();

  DateTime? lastPreventive;

  DateTime? nextPreventive;

  DateTime? lastCorrective;

  // QR Code identifier
  String qrCode = '';

  DateTime createdAt = DateTime.now();

  DateTime updatedAt = DateTime.now();
}

@collection
class SectorModel {
  Id id = Isar.autoIncrement;

  String name = '';

  String description = '';

  DateTime createdAt = DateTime.now();
}