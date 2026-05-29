import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../shared/widgets/industrial_scaffold.dart';
import '../../../../../shared/widgets/status_chip.dart';
import '../../../../../shared/widgets/status_colors.dart';

import '../../../../core/models/industrial_models.dart';
import '../providers/occurrences_providers.dart';

class OccurrenceDetailScreen extends ConsumerWidget {
  const OccurrenceDetailScreen({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncDetail = ref.watch(occurrenceByIdProvider(id));

    return IndustrialScaffold(
      title: 'Detalhe da Ocorrência',
      selectedIndex: 2,
      actions: [
        IconButton(
          tooltip: 'Atualizar',
          onPressed: () => ref.invalidate(occurrenceByIdProvider(id)),
          icon: const Icon(Icons.refresh_outlined),
        ),
      ],
      body: asyncDetail.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(e.toString())),
        data: (detail) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(
                '${detail.machineCode} - ${detail.sector}',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 8),
              Text(detail.description),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  StatusChip(
                    label: detail.priority.name,
                    color: StatusColors.priority(detail.priority),
                  ),
                  StatusChip(
                    label: detail.status.toString().split('.').last,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  StatusChip(
                    label: detail.syncStatus.toString().split('.').last,
                    color: StatusColors.sync(detail.syncStatus),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Text(
                'Ações',
                style: TextStyle(fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 12),
              FilledButton.icon(
                onPressed: () => context.go('/occurrences/$id/inspection'),
                icon: const Icon(Icons.fact_check_outlined),
                label: const Text('Iniciar inspeção'),
              ),
              const SizedBox(height: 12),
              FilledButton.icon(
                onPressed: () => context.go('/occurrences/$id/corrective'),
                icon: const Icon(Icons.build_outlined),
                label: const Text('Gerar corretiva'),
              ),
            ],
          );
        },
      ),
    );
  }
}
