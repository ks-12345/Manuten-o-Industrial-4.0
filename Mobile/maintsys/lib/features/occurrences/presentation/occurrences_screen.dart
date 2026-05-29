import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/enums/maintenance_enums.dart';
import '../../../shared/widgets/industrial_scaffold.dart';
import '../../../shared/widgets/status_chip.dart';
import '../../../shared/widgets/status_colors.dart';
import '../../dashboard/presentation/dashboard_controller.dart';

class OccurrencesScreen extends ConsumerWidget {
  const OccurrencesScreen({super.key});

  static const route = '/occurrences';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final snapshot = ref.watch(dashboardSnapshotProvider);

    return IndustrialScaffold(
      title: 'Ocorrencias',
      selectedIndex: 2,
      actions: [
        IconButton(
          tooltip: 'Nova ocorrencia',
          onPressed: () {},
          icon: const Icon(Icons.add_circle_outline),
        ),
      ],
      body: snapshot.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('$error')),
        data: (data) => ListView.separated(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
          itemCount: data.occurrences.length,
          separatorBuilder: (_, _) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            final occurrence = data.occurrences[index];
            final priorityColor = StatusColors.priority(occurrence.priority);

            return Card(
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            '${occurrence.machineCode} - ${occurrence.sector}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.w800),
                          ),
                        ),
                        StatusChip(
                          label: occurrence.priority.label,
                          color: priorityColor,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(occurrence.description),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        StatusChip(
                          label: occurrence.status.label,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        StatusChip(
                          label: occurrence.syncStatus.label,
                          color: StatusColors.sync(occurrence.syncStatus),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
