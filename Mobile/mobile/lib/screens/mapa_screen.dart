// ============================================
// SCREEN 5: MAPA DAS INSTALAÇÕES
// ============================================

class MapaInstalacoesScreen extends StatefulWidget {
  const MapaInstalacoesScreen({super.key});

  @override
  State<MapaInstalacoesScreen> createState() => _MapaInstalacoesScreenState();
}

class _MapaInstalacoesScreenState extends State<MapaInstalacoesScreen> {
  String _selectedArea = 'Todas';
  
  final List<Map<String, dynamic>> areas = [
    {'nome': 'Usinagem', 'x': 0.2, 'y': 0.3, 'status': 'ATIVAS', 'maquinas': 4},
    {'nome': 'Solda', 'x': 0.6, 'y': 0.2, 'status': 'MANUTENÇÃO', 'maquinas': 2},
    {'nome': 'Pintura', 'x': 0.4, 'y': 0.6, 'status': 'ALERTA', 'maquinas': 1},
    {'nome': 'Montagem', 'x': 0.8, 'y': 0.5, 'status': 'ATIVAS', 'maquinas': 3},
    {'nome': 'Qualidade', 'x': 0.3, 'y': 0.8, 'status': 'ATIVAS', 'maquinas': 2},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SENAIAppBar(title: 'Mapa das Instalações'),
      drawer: const SENAINavigationDrawer(currentRoute: '/mapa'),
      body: Column(
        children: [
          // Legenda
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildLegendMap('Ativas', const Color(0xFF4CAF50)),
                _buildLegendMap('Manutenção', const Color(0xFFFF9800)),
                _buildLegendMap('Alerta', const Color(0xFFF44336)),
              ],
            ),
          ),
          
          // Mapa Interativo
          Expanded(
            child: InteractiveViewer(
              boundaryMargin: const EdgeInsets.all(20),
              minScale: 0.5,
              maxScale: 3,
              child: Container(
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Stack(
                  children: [
                    // Grid de fundo
                    CustomPaint(
                      size: Size.infinite,
                      painter: GridPainter(),
                    ),
                    // Áreas da fábrica
                    ...areas.map((area) => Positioned(
                      left: area['x'] * 300,
                      top: area['y'] * 400,
                      child: GestureDetector(
                        onTap: () {
                          setState(() => _selectedArea = area['nome']);
                          _showAreaDetails(area);
                        },
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: _getStatusColor(area['status']).withOpacity(0.2),
                            border: Border.all(
                              color: _getStatusColor(area['status']),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              StatusIndicator(status: area['status']),
                              const SizedBox(height: 4),
                              Text(
                                area['nome'],
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                '${area['maquinas']} máq.',
                                style: TextStyle(
                                  fontSize: 9,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )),
                  ],
                ),
              ),
            ),
          ),
          
          // Lista de Áreas
          Container(
            height: 120,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: areas.length,
              itemBuilder: (context, index) {
                final area = areas[index];
                final isSelected = _selectedArea == area['nome'];
                return Container(
                  width: 140,
                  margin: const EdgeInsets.only(right: 12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFFFFEBEE) : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected ? const Color(0xFFB71C1C) : Colors.grey[300]!,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          StatusIndicator(status: area['status']),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              area['nome'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Text(
                        '${area['maquinas']} máquinas',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
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

  Widget _buildLegendMap(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  void _showAreaDetails(Map<String, dynamic> area) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                StatusIndicator(status: area['status']),
                const SizedBox(width: 12),
                Text(
                  area['nome'],
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text('Máquinas: ${area['maquinas']}'),
            const SizedBox(height: 8),
            Text('Status: ${area['status']}'),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const ListaMaquinasScreen()));
                },
                child: const Text('Ver Máquinas'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey[300]!
      ..strokeWidth = 1;

    for (double i = 0; i < size.width; i += 40) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }
    for (double i = 0; i < size.height; i += 40) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
 
