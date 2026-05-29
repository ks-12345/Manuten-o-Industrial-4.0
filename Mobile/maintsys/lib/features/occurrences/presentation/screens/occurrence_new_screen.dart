import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:isar/isar.dart';

import '../../../../../core/database/isar_service.dart';
import '../../../../../core/models/industrial_models.dart';
import '../../../../../shared/constants/status_enum.dart';
import '../../../../../core/enums/maintenance_enums.dart';

import '../../../../../shared/widgets/industrial_scaffold.dart';
import '../../../../../shared/widgets/error_view.dart';
import '../../../../../shared/widgets/status_colors.dart';

import '../../../machines/domain/entities/machine_entity.dart';
import '../../domain/repositories/occurrence_repository.dart';
import '../../data/repositories/occurrence_repository_impl.dart';

final machinesListFromIsarProvider = FutureProvider<List<MachineEntity>>((
  ref,
) async {
  final isar = await IsarService.instance.database;
  return isar.machineEntitys.where().findAll();
});

class OccurrenceNewScreen extends ConsumerStatefulWidget {
  const OccurrenceNewScreen({super.key});

  @override
  ConsumerState<OccurrenceNewScreen> createState() =>
      _OccurrenceNewScreenState();
}

class _OccurrenceNewScreenState extends ConsumerState<OccurrenceNewScreen> {
  final _descriptionController = TextEditingController();
  PriorityLevel _priority = PriorityLevel.medium;
  MachineEntity? _selectedMachine;

  bool _submitting = false;

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final machinesAsync = ref.watch(machinesListFromIsarProvider);

    return IndustrialScaffold(
      title: 'Nova Ocorrência',
      selectedIndex: 2,
      body: machinesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => ErrorView(
          message: e.toString(),
          onRetry: () => ref.invalidate(machinesListFromIsarProvider),
        ),
        data: (machines) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const Text(
                'Selecione a máquina',
                style: TextStyle(fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<MachineEntity>(
                value: _selectedMachine,
                isExpanded: true,
                items: machines
                    .map(
                      (m) => DropdownMenuItem(
                        value: m,
                        child: Text('${m.code} - ${m.name}'),
                      ),
                    )
                    .toList(),
                onChanged: (val) => setState(() => _selectedMachine = val),
                decoration: const InputDecoration(border: OutlineInputBorder()),
              ),
              const SizedBox(height: 16),
              const Text(
                'Descrição',
                style: TextStyle(fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _descriptionController,
                minLines: 3,
                maxLines: 5,
                decoration: const InputDecoration(
                  hintText: 'Descreva o problema observado...',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Prioridade',
                style: TextStyle(fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: PriorityLevel.values.map((p) {
                  final selected = p == _priority;
                  final color = StatusColors.priority(p);
                  return ChoiceChip(
                    selected: selected,
                    label: Text(p.label),
                    selectedColor: color.withValues(alpha: 0.18),
                    backgroundColor: color.withValues(alpha: 0.08),
                    onSelected: (_) => setState(() => _priority = p),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),
              _submitting
                  ? const Center(child: CircularProgressIndicator())
                  : FilledButton.icon(
                      onPressed:
                          (_selectedMachine == null ||
                              _descriptionController.text.trim().isEmpty)
                          ? null
                          : () async {
                              setState(() => _submitting = true);
                              try {
                                final repo = ref.read(
                                  occurrenceRepositoryImplProvider,
                                );
                                final created = await repo.create(
                                  machine: _selectedMachine!,
                                  description: _descriptionController.text
                                      .trim(),
                                  priority: _priority.toOccurrencePriority(),
                                );

                                if (!context.mounted) return;
                                context.go('/occurrences/${created.id}');
                              } catch (e) {
                                if (!context.mounted) return;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(e.toString())),
                                );
                              } finally {
                                if (mounted) {
                                  setState(() => _submitting = false);
                                }
                              }
                            },
                      icon: const Icon(Icons.save_outlined),
                      label: const Text('Salvar offline'),
                    ),
            ],
          );
        },
      ),
    );
  }
}

extension _PriorityMapper on PriorityLevel {
  OccurrencePriority toOccurrencePriority() => switch (this) {
    PriorityLevel.low => OccurrencePriority.low,
    PriorityLevel.medium => OccurrencePriority.medium,
    PriorityLevel.high => OccurrencePriority.high,
    PriorityLevel.critical => OccurrencePriority.critical,
  };
}
