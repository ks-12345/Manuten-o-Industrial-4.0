import 'package:isar/isar.dart';

part 'part_replacement_model.g.dart';

@collection
class PartReplacementModel {
  Id id = Isar.autoIncrement;

  late int occurrenceId;
  late String partName;
  late int quantity;

  String? reason;
  String? observations;

  DateTime createdAt = DateTime.now();
}
