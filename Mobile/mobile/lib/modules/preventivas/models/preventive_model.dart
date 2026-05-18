import 'package:isar/isar.dart';

part 'preventive_model.g.dart';

@collection
class PreventiveModel {
  Id id = Isar.autoIncrement;

  late int machineId;

  // Frequência em dias ou rótulo (7/15/30/mensal/trimestral)
  late String frequency;

  DateTime? nextPreventive;
  DateTime createdAt = DateTime.now();
  DateTime updatedAt = DateTime.now();
}
