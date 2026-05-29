import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/widgets/industrial_scaffold.dart';
import '../../../shared/widgets/status_colors.dart';
import '../../dashboard/presentation/dashboard_controller.dart';

class IndustrialMapScreen extends ConsumerWidget {
  const IndustrialMapScreen({super.key});

  static const route = '/industrial-map';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final snapshot = ref.watch(dashboardSnapshotProvider);

    return IndustrialScaffold(
      title: 'Mapa Industrial',
      selectedIndex: 3,
      body: snapshot.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('$error')),
        data: (data) => Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final columns = constraints.maxWidth > 720 ? 4 : 2;

              return GridView.builder(
                itemCount: data.machines.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: columns,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 1.05,
                ),
                itemBuilder: (context, index) {
                  final machine = data.machines[index];
                  final color = StatusColors.machine(machine.status);

                  return Card(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.sensors, color: color),
                                const Spacer(),
                                Container(
                                  width: 12,
                                  height: 12,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: color,
                                    boxShadow: [
                                      BoxShadow(
                                        color: color.withValues(alpha: 0.45),
                                        blurRadius: 14,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Text(
                              machine.code,
                              style: Theme.of(context).textTheme.headlineSmall
                                  ?.copyWith(fontWeight: FontWeight.w900),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              machine.name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              machine.sector,
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.62),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
