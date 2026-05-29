import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/enums/maintenance_enums.dart';
import '../../../shared/widgets/industrial_scaffold.dart';
import '../../../shared/widgets/status_chip.dart';
import '../../../shared/widgets/status_colors.dart';
import '../../dashboard/presentation/dashboard_controller.dart';

class MachineListScreen extends ConsumerWidget {
  const MachineListScreen({super.key});

  static const route = '/machines';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final snapshot = ref.watch(dashboardSnapshotProvider);

    return IndustrialScaffold(
      title: 'Maquinas',
      selectedIndex: 1,
      actions: [
        IconButton(
          tooltip: 'Filtrar maquinas',
          onPressed: () {},
          icon: const Icon(Icons.tune),
        ),
      ],
      body: snapshot.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('$error')),
        data: (data) => ListView.separated(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
          itemCount: data.machines.length,
          separatorBuilder: (_, _) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            final machine = data.machines[index];
            final color = StatusColors.machine(machine.status);

            return Card(
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: color.withValues(alpha: 0.4)),
                      ),
                      child: Icon(Icons.precision_manufacturing, color: color),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${machine.code} - ${machine.name}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.w800),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${machine.sector} | MTBF ${machine.mtbfHours.toStringAsFixed(0)}h | MTTR ${machine.mttrHours.toStringAsFixed(1)}h',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    StatusChip(label: machine.status.label, color: color),
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
