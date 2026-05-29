import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_constants.dart';
import '../../dashboard/presentation/dashboard_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const route = '/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future<void>.delayed(const Duration(milliseconds: 900), () {
      if (mounted) context.go(DashboardScreen.route);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.precision_manufacturing, size: 64),
            SizedBox(height: 18),
            Text(
              AppConstants.appName,
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900),
            ),
            SizedBox(height: 6),
            Text(AppConstants.appSubtitle),
            SizedBox(height: 28),
            SizedBox(width: 160, child: LinearProgressIndicator()),
          ],
        ),
      ),
    );
  }
}
