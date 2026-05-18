import 'package:isar/isar.dart';

part 'occurrence_model.g.dart';

enum OccurrenceStatus { open, analysis, maintenance, finished, cancelled }
enum OccurrencePriority { low, medium, high, critical }

@collection
class OccurrenceModel {
  Id id = Isar.autoIncrement;

  late int machineId;
  late int reportedByUserId;
  int? assignedTechnicianId;

  late String title;
  late String description;
  String? observations;
  String? photoPath;

  @Enumerated(EnumType.name)
  late OccurrenceStatus status;

  @Enumerated(EnumType.name)
  late OccurrencePriority priority;

  DateTime createdAt = DateTime.now();
  DateTime updatedAt = DateTime.now();
  DateTime? finishedAt;
}