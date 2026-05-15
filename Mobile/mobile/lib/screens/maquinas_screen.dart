// ============================================
// SCREEN 6: LISTA DE MÁQUINAS
// ============================================

class ListaMaquinasScreen extends StatefulWidget {
  const ListaMaquinasScreen({super.key});

  @override
  State<ListaMaquinasScreen> createState() => _ListaMaquinasScreenState();
}

class _ListaMaquinasScreenState extends State<ListaMaquinasScreen> {
  String _filter = 'Todas';
  
  final List<Map<String, dynamic>> maquinas = [
    {
      'nome': 'Torno CNC #01',
      'tipo': 'Usinagem',
      'status': 'ATIVAS',
      'local': 'Laboratório de Usinagem',
      'ultimaManutencao': '10/05/2026',
      'proximaManutencao': '10/06/2026',
    },
    {
      'nome': 'Fresadora Universal #02',
      'tipo': 'Usinagem',
      'status': 'MANUTENÇÃO',
      'local': 'Laboratório de Usinagem',
      'ultimaManutencao': '01/05/2026',
      'proximaManutencao': 'Em andamento',
    },
    {
      'nome': 'Solda MIG/MAG #01',
      'tipo': 'Solda',
      'status': 'ALERTA',
      'local': 'Laboratório de Soldagem',
      'ultimaManutencao': '15/04/2026',
      'proximaManutencao': 'Atrasada',
    },
    {
      'nome': 'Centro de Usinagem CNC #05',
      'tipo': 'Usinagem',
      'status': 'ATIVAS',
      'local': 'Laboratório de Usinagem',
      'ultimaManutencao': '20/05/2026',
      'proximaManutencao': '20/06/2026',
    },
    {
      'nome': 'Torno Mecânico #08',
      'tipo': 'Usinagem',
      'status': 'ATIVAS',
      'local': 'Laboratório de Usinagem',
      'ultimaManutencao': '12/05/2026',
      'proximaManutencao': '12/06/2026',
    },
    {
      'nome': 'Fresadora CNC #03',
      'tipo': 'Usinagem',
      'status': 'MANUTENÇÃO',
      'local': 'Laboratório de Usinagem',
      'ultimaManutencao': '05/05/2026',
      'proximaManutencao': '15/05/2026',
    },
  ];

  List<Map<String, dynamic>> get filteredMaquinas {
    if (_filter == 'Todas') return maquinas;
    return maquinas.where((m) => m['status'] == _filter).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SENAIAppBar(title: 'Máquinas'),
      drawer: const SENAINavigationDrawer(currentRoute: '/maquinas'),
      body: Column(
        children: [
          // Filtros
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildFilterChip('Todas', null),
                  const SizedBox(width: 8),
                  _buildFilterChip('Ativas', const Color(0xFF4CAF50)),
                  const SizedBox(width: 8),
                  _buildFilterChip('Manutenção', const Color(0xFFFF9800)),
                  const SizedBox(width: 8),
                  _buildFilterChip('Alerta', const Color(0xFFF44336)),
                ],
              ),
            ),
          ),
          
          // Lista
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filteredMaquinas.length,
              itemBuilder: (context, index) {
                final maquina = filteredMaquinas[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color: _getStatusColor(maquina['status']).withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: _getStatusColor(maquina['status']).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.precision_manufacturing,
                        color: _getStatusColor(maquina['status']),
                      ),
                    ),
                    title: Row(
                      children: [
                        Expanded(
                          child: Text(
                            maquina['nome'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        StatusIndicator(status: maquina['status']),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        Text(
                          '${maquina['tipo']} • ${maquina['local']}',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.calendar_today, size: 12, color: Colors.grey[500]),
                            const SizedBox(width: 4),
                            Text(
                              'Última: ${maquina['ultimaManutencao']}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[500],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    trailing: const Icon(Icons.chevron_right, color: Color(0xFFB71C1C)),
                    onTap: () => _showMachineDetails(maquina),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const ChecklistInspecaoScreen()));
        },
        backgroundColor: const Color(0xFFB71C1C),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildFilterChip(String label, Color? color) {
    final isSelected = _filter == label;
    return FilterChip(
      selected: isSelected,
      showCheckmark: false,
      backgroundColor: Colors.grey[100],
      selectedColor: color?.withOpacity(0.2) ?? const Color(0xFFB71C1C).withOpacity(0.2),
      side: BorderSide(
        color: isSelected ? (color ?? const Color(0xFFB71C1C)) : Colors.grey[300]!,
      ),
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (color != null) ...[
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 6),
          ],
          Text(
            label,
            style: TextStyle(
              color: isSelected ? (color ?? const Color(0xFFB71C1C)) : Colors.grey[700],
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
      onSelected: (selected) {
        setState(() => _filter = label);
      },
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'ATIVAS': return const Color(0xFF4CAF50);
      case 'MANUTENÇÃO': return const Color(0xFFFF9800);
      case 'ALERTA': return const Color(0xFFF44336);
      default: return Colors.grey;
    }
  }

  void _showMachineDetails(Map<String, dynamic> maquina) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          padding: const EdgeInsets.all(24),
          constraints: const BoxConstraints(maxWidth: 400),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: _getStatusColor(maquina['status']).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.precision_manufacturing,
                      color: _getStatusColor(maquina['status']),
                      size: 32,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          maquina['nome'],
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            StatusIndicator(status: maquina['status']),
                            const SizedBox(width: 8),
                            Text(
                              maquina['status'],
                              style: TextStyle(
                                color: _getStatusColor(maquina['status']),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(height: 32),
              _buildDetailRow('Tipo', maquina['tipo']),
              _buildDetailRow('Localização', maquina['local']),
              _buildDetailRow('Última Manutenção', maquina['ultimaManutencao']),
              _buildDetailRow('Próxima Manutenção', maquina['proximaManutencao']),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(context, MaterialPageRoute(builder: (_) => const ChecklistInspecaoScreen()));
                      },
                      icon: const Icon(Icons.checklist),
                      label: const Text('Nova Inspeção'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Fechar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              label,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
