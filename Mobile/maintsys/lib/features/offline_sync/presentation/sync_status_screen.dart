import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:isar/isar.dart';

import '../../../core/sync/sync_manager.dart';

import '../../../core/sync/sync_queue_entity.dart';

import '../../../shared/constants/status_enum.dart';
import '../../../core/enums/maintenance_enums.dart' as core_enums;

import '../../../shared/widgets/industrial_scaffold.dart';

import '../../../shared/widgets/status_chip.dart';
import '../../../shared/widgets/status_colors.dart';

import '../../../shared/widgets/error_view.dart';
import '../../../shared/widgets/empty_state.dart';

class SyncStatusScreen extends ConsumerWidget {
  const SyncStatusScreen({super.key});

  static const route = '/sync';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isar = ref.watch(_isarProvider);
    final syncManager = ref.watch(syncManagerProvider);

    final queueFuture = ref.watch(_syncQueueFutureProvider(isar));

    return IndustrialScaffold(
      title: 'Fila Offline',
      selectedIndex: 4,
      actions: [
        IconButton(
          tooltip: 'Sincronizar agora',
          onPressed: () async {
            await syncManager.processQueue();
            ref.invalidate(_syncQueueFutureProvider(isar));
          },
          icon: const Icon(Icons.cloud_sync_outlined),
        ),
      ],
      body: queueFuture.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => ErrorView(
          message: error.toString(),
          onRetry: () => ref.invalidate(_syncQueueFutureProvider(isar)),
          dense: true,
        ),
        data: (queue) {
          if (queue.isEmpty) {
            return const EmptyState(
              icon: Icons.cloud_sync_outlined,
              message: 'Nenhuma pendencia na fila offline.',
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
            itemCount: queue.length,
            separatorBuilder: (_, _) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final item = queue[index];
              final color = StatusColors.sync(
                core_enums.SyncStatus.values.firstWhere(
                  (v) => v.name == item.syncStatus.name,
                  orElse: () => core_enums.SyncStatus.pending,
                ),
              );

              return Card(
                child: ListTile(
                  contentPadding: const EdgeInsets.all(14),
                  leading: Icon(Icons.storage_outlined, color: color),
                  title: Text(
                    item.entityType.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    'Op: ${item.operation} | Tentativas: ${item.attempts} | Local: ${item.localId}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: StatusChip(
                    label: item.syncStatus.label,

                    color: color,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

final _isarProvider = Provider<Isar>((ref) {
  throw UnimplementedError('Should be overridden by SyncStatusScreen');
});

final _syncQueueFutureProvider =
    FutureProvider.family<List<SyncQueueEntity>, Isar>((ref, isar) async {
      return isar.syncQueueEntitys.where().findAll();
    });
