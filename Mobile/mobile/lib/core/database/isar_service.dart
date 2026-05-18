import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../../modules/auth/models/user_model.dart';
import '../../modules/maquinas/models/machine_model.dart';
import '../../modules/ocorrencias/models/occurrence_model.dart';
import '../../modules/checklist/models/checklist_model.dart';
import '../../modules/preventivas/models/preventive_model.dart';
import '../../modules/corretivas/models/corrective_model.dart';
// O schema é gerado pelo Isar (ou stubs no ambiente).
import '../../modules/part_replacements/models/part_replacement_model.dart';
// import '../../modules/part_replacements/models/part_replacement_model_schema.dart';

class IsarService {
  IsarService._();
  static late final Isar isar;

  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();

    isar = await Isar.open(
      [
        UserModelSchema,
        MachineModelSchema,
        SectorModelSchema,
        OccurrenceModelSchema,
        ChecklistModelSchema,
        ChecklistQuestionModelSchema,
        ChecklistAnswerModelSchema,
        PreventiveModelSchema,
        CorrectiveModelSchema,
        PartReplacementModelSchema,
      ],
      directory: dir.path,
      inspector: true, // desabilitar em produção
    );

    await _seedDataIfEmpty();
  }

  static Future<void> _seedDataIfEmpty() async {
    final count = await isar.machineModels.count();
    if (count == 0) {
      await _insertMockData();
    }
  }

  static Future<void> _insertMockData() async {
    await isar.writeTxn(() async {
      final usinagem = SectorModel()
        ..name = 'Usinagem'
        ..description = 'Setor de usinagem CNC e convencional';
      await isar.sectorModels.put(usinagem);

      final torno = MachineModel()
        ..name = 'Torno CNC TRM-01'
        ..model = 'ROMI GL-240'
        ..patrimony = '10.452'
        ..voltage = '380V'
        ..sectorId = usinagem.id
        ..status = MachineStatus.broken
        ..installationDate = DateTime(2020, 3, 15)
        ..qrCode =
            'MAINTSYS-${usinagem.id}-${DateTime.now().millisecondsSinceEpoch}';

      await isar.machineModels.put(torno);
    });
  }
}
