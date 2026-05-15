// Indicador de Status da Máquina
class StatusIndicator extends StatelessWidget {
  final String status; // 'ATIVAS', 'MANUTENÇÃO', 'ALERTA'

  const StatusIndicator({super.key, required this.status});

  Color get statusColor {
    switch (status.toUpperCase()) {
      case 'ATIVAS':
        return const Color(0xFF4CAF50);
      case 'MANUTENÇÃO':
        return const Color(0xFFFF9800);
      case 'ALERTA':
        return const Color(0xFFF44336);
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        color: statusColor,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
        boxShadow: [
          BoxShadow(
            color: statusColor.withOpacity(0.4),
            blurRadius: 4,
            spreadRadius: 1,
          ),
        ],
      ),
    );
  }
}

