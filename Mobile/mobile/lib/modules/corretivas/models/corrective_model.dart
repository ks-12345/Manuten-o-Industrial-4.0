import 'package:isar/isar.dart';

part 'corrective_model.g.dart';

@collection
class CorrectiveModel {
  Id id = Isar.autoIncrement;

  late int machineId;
  late int occurrenceId;

  String? summary;
  DateTime createdAt = DateTime.now();
}
