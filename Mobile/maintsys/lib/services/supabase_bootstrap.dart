import 'package:supabase_flutter/supabase_flutter.dart';

import '../core/constants/app_constants.dart';

class SupabaseBootstrap {
  const SupabaseBootstrap._();

  static Future<bool> tryInitialize() async {
    const url = String.fromEnvironment(AppConstants.supabaseUrlEnv);
    const anonKey = String.fromEnvironment(AppConstants.supabaseAnonKeyEnv);

    if (url.isEmpty || anonKey.isEmpty) {
      return false;
    }

    await Supabase.initialize(url: url, anonKey: anonKey);
    return true;
  }
}
