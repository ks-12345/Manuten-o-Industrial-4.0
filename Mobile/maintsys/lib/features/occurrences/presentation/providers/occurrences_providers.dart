import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/models/industrial_models.dart';
import '../../data/repositories/occurrence_repository_impl.dart';
import '../../domain/repositories/occurrence_repository.dart';

final occurrencesListProvider = FutureProvider<List<OccurrenceSummary>>((
  ref,
) async {
  final repo = ref.watch(occurrenceRepositoryImplProvider);
  return repo.watchAll();
});

final occurrenceByIdProvider = FutureProvider.autoDispose
    .family<OccurrenceSummary, String>((ref, id) async {
      final repo = ref.watch(occurrenceRepositoryImplProvider);
      return repo.getById(id);
    });
