
// ============================================
// SCREEN 4: DASHBOARD
// ============================================

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SENAIAppBar(
        title: 'Dashboard',
        onMenuPressed: () => Scaffold.of(context).openDrawer(),
      ),
      drawer: const SENAINavigationDrawer(currentRoute: '/dashboard'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cards de Status
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.1,
              children: const [
                StatusCard(
                  icon: Icons.check_circle_outline,
                  label: 'Máquinas\nAtivas',
                  value: '8',
                  color: Color(0xFF4CAF50),
                ),
                StatusCard(
                  icon: Icons.build_circle_outlined,
                  label: 'Em\nManutenção',
                  value: '4',
                  color: Color(0xFFFF9800),
                ),
                StatusCard(
                  icon: Icons.warning_amber_rounded,
                  label: 'Alertas\nPendentes',
                  value: '3',
                  color: Color(0xFFF44336),
                ),
                StatusCard(
                  icon: Icons.schedule_outlined,
                  label: 'Manutenções\nProgramadas',
                  value: '1',
                  color: Color(0xFF2196F3),
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            // Gráfico de Manutenções (simulado com containers)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Manutenções por Mês',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 150,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildBar('Jan', 0.4, const Color(0xFFB71C1C)),
                        _buildBar('Fev', 0.6, const Color(0xFFB71C1C)),
                        _buildBar('Mar', 0.3, const Color(0xFFB71C1C)),
                        _buildBar('Abr', 0.8, const Color(0xFFB71C1C)),
                        _buildBar('Mai', 0.5, const Color(0xFFB71C1C)),
                        _buildBar('Jun', 0.7, const Color(0xFFB71C1C)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            
            // Gráfico de Status (simulado)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Status das Máquinas',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 120,
                          child: CustomPaint(
                            size: const Size(120, 120),
                            painter: PieChartPainter(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 24),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildLegendItem('Ativas', const Color(0xFF4CAF50), '8'),
                          const SizedBox(height: 8),
                          _buildLegendItem('Manutenção', const Color(0xFFFF9800), '4'),
                          const SizedBox(height: 8),
                          _buildLegendItem('Alerta', const Color(0xFFF44336), '3'),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            
            // Ações Rápidas
            const Text(
              'Ações Rápidas',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildQuickAction(
                    icon: Icons.add_circle_outline,
                    label: 'Nova Inspeção',
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const ChecklistInspecaoScreen()));
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildQuickAction(
                    icon: Icons.map_outlined,
                    label: 'Ver Mapa',
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const MapaInstalacoesScreen()));
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBar(String label, double height, Color color) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 30,
          height: 120 * height,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(height: 8),
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
      ],
    );
  }

  Widget _buildLegendItem(String label, Color color, String value) {
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
        const SizedBox(width: 8),
        Text('$label: ', style: const TextStyle(fontSize: 14)),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildQuickAction({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFB71C1C).withOpacity(0.2)),
        ),
        child: Column(
          children: [
            Icon(icon, color: const Color(0xFFB71C1C), size: 32),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                color: Color(0xFFB71C1C),
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// Painter para gráfico de pizza
class PieChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    
    final paint1 = Paint()..color = const Color(0xFF4CAF50);
    final paint2 = Paint()..color = const Color(0xFFFF9800);
    final paint3 = Paint()..color = const Color(0xFFF44336);
    
    // Ativas: 8/15 = 192 graus
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -1.57,
      3.35,
      true,
      paint1,
    );
    // Manutenção: 4/15 = 96 graus
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      1.78,
      1.68,
      true,
      paint2,
    );
    // Alerta: 3/15 = 72 graus
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      3.46,
      1.26,
      true,
      paint3,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
