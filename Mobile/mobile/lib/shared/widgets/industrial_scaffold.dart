import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_colors.dart';

class IndustrialScaffold extends StatelessWidget {
  final Widget child;
  const IndustrialScaffold({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(children: [
        _IndustrialTopBar(),
        Expanded(
          child: Row(children: [
            _IndustrialSidebar(),
            Expanded(child: child),
          ]),
        ),
      ]),
    );
  }
}

class _IndustrialTopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      color: const Color(0xFF0D1018),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(children: [
        // Logo
        const _Logo(),
        const SizedBox(width: 20),
        const VerticalDivider(color: AppColors.border, width: 1, indent: 12, endIndent: 12),
        // Nav items
        const SizedBox(width: 8),
        ..._navItems(context),
        const Spacer(),
        // Status
        const _StatusIndicator(),
      ]),
    );
  }

  List<Widget> _navItems(BuildContext context) => [
    _NavItem(icon: Icons.dashboard_outlined,    label: 'DASHBOARD',    path: '/dashboard'),
    _NavItem(icon: Icons.map_outlined,           label: 'MAPA',         path: '/mapa'),
    _NavItem(icon: Icons.precision_manufacturing, label: 'MÁQUINAS',    path: '/maquinas'),
    _NavItem(icon: Icons.warning_amber_outlined, label: 'OCORRÊNCIAS',  path: '/ocorrencias'),
    _NavItem(icon: Icons.checklist_outlined,     label: 'CHECKLIST',    path: '/checklist/0'),
    _NavItem(icon: Icons.history,                label: 'HISTÓRICO',    path: '/historico'),
  ];
}

class _Logo extends StatelessWidget {
  const _Logo();
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      const Icon(Icons.settings_suggest, color: AppColors.primaryLight, size: 20),
      const SizedBox(width: 8),
      Text(
        'MAINTSYS',
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
          color: AppColors.primaryLight,
          letterSpacing: 3,
          fontWeight: FontWeight.w700,
        ),
      ),
    ]);
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String path;
  const _NavItem({required this.icon, required this.label, required this.path});

  @override
  Widget build(BuildContext context) {
    final isActive = GoRouterState.of(context).uri.path.startsWith(path.split('/')[1] == '' ? path : '/${path.split('/')[1]}');
    return InkWell(
      onTap: () => context.go(path),
      borderRadius: BorderRadius.circular(4),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          border: isActive
            ? const Border(bottom: BorderSide(color: AppColors.primaryLight, width: 2))
            : null,
        ),
        child: Row(children: [
          Icon(icon, size: 14, color: isActive ? AppColors.primaryLight : AppColors.textMuted),
          const SizedBox(width: 5),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              letterSpacing: 1,
              color: isActive ? AppColors.primaryLight : AppColors.textMuted,
              fontWeight: isActive ? FontWeight.w700 : FontWeight.w400,
            ),
          ),
        ]),
      ),
    );
  }
}

class _StatusIndicator extends StatelessWidget {
  const _StatusIndicator();
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(
        width: 7, height: 7,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.success,
          boxShadow: [BoxShadow(color: AppColors.success, blurRadius: 4)],
        ),
      ),
      const SizedBox(width: 6),
      const Text('OFFLINE — LOCAL', style: TextStyle(fontSize: 10, color: AppColors.textMuted, letterSpacing: 1)),
    ]);
  }
}

class _IndustrialSidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 52,
      color: const Color(0xFF0D1018),
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(children: [
        _SidebarIcon(icon: Icons.dashboard_outlined,     path: '/dashboard',    tooltip: 'Dashboard'),
        _SidebarIcon(icon: Icons.map_outlined,            path: '/mapa',         tooltip: 'Mapa'),
        _SidebarIcon(icon: Icons.precision_manufacturing, path: '/maquinas',     tooltip: 'Máquinas'),
        const _SidebarDivider(),
        _SidebarIcon(icon: Icons.warning_amber_outlined,  path: '/ocorrencias',  tooltip: 'Ocorrências'),
        _SidebarIcon(icon: Icons.search_outlined,         path: '/mapa',         tooltip: 'Inspeções'),
        _SidebarIcon(icon: Icons.checklist_outlined,      path: '/checklist/0',  tooltip: 'Checklist'),
        const _SidebarDivider(),
        _SidebarIcon(icon: Icons.history,                 path: '/historico',    tooltip: 'Histórico'),
        const Spacer(),
        _SidebarIcon(icon: Icons.logout,                  path: '/login',        tooltip: 'Sair'),
      ]),
    );
  }
}

class _SidebarIcon extends StatelessWidget {
  final IconData icon;
  final String path;
  final String tooltip;
  const _SidebarIcon({required this.icon, required this.path, required this.tooltip});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: () => context.go(path),
        borderRadius: BorderRadius.circular(6),
        child: Container(
          width: 36, height: 36,
          margin: const EdgeInsets.only(bottom: 4),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(6)),
          child: Icon(icon, size: 18, color: AppColors.textMuted),
        ),
      ),
    ).animate().fadeIn(duration: 300.ms);
  }
}

class _SidebarDivider extends StatelessWidget {
  const _SidebarDivider();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24, height: 1,
      margin: const EdgeInsets.symmetric(vertical: 4),
      color: AppColors.border,
    );
  }
}