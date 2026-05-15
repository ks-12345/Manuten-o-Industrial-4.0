// Drawer de Navegação
class SENAINavigationDrawer extends StatelessWidget {
  final String currentRoute;

  const SENAINavigationDrawer({super.key, this.currentRoute = ''});

  @override
  Widget build(BuildContext context) {
    final menuItems = [
      {'icon': Icons.dashboard_outlined, 'title': 'Dashboard', 'route': '/dashboard'},
      {'icon': Icons.map_outlined, 'title': 'Mapa das Instalações', 'route': '/mapa'},
      {'icon': Icons.precision_manufacturing, 'title': 'Máquinas', 'route': '/maquinas'},
      {'icon': Icons.checklist_outlined, 'title': 'Checklist', 'route': '/checklist'},
      {'icon': Icons.history_outlined, 'title': 'Histórico', 'route': '/historico'},
      {'icon': Icons.settings_outlined, 'title': 'Configurações', 'route': '/config'},
    ];

    return Drawer(
      child: Column(
        children: [
          Container(
            color: const Color(0xFFB71C1C),
            padding: const EdgeInsets.all(20),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    'https://www.senai.br/wp-content/uploads/2020/01/logo-senai-1.png',
                    height: 40,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Gestão de Manutenção',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'João Oliveira',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: menuItems.length,
              itemBuilder: (context, index) {
                final item = menuItems[index];
                final isSelected = currentRoute == item['route'];
                return ListTile(
                  leading: Icon(
                    item['icon'] as IconData,
                    color: isSelected ? const Color(0xFFB71C1C) : Colors.grey,
                  ),
                  title: Text(
                    item['title'] as String,
                    style: TextStyle(
                      color: isSelected ? const Color(0xFFB71C1C) : Colors.black87,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                  tileColor: isSelected ? const Color(0xFFFFEBEE) : null,
                  onTap: () {
                    Navigator.pop(context);
                    if (item['route'] == '/dashboard') {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const DashboardScreen()));
                    } else if (item['route'] == '/mapa') {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const MapaInstalacoesScreen()));
                    } else if (item['route'] == '/maquinas') {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const ListaMaquinasScreen()));
                    } else if (item['route'] == '/checklist') {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const ChecklistInspecaoScreen()));
                    }
                  },
                );
              },
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.grey),
            title: const Text('Sair', style: TextStyle(color: Colors.grey)),
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}
