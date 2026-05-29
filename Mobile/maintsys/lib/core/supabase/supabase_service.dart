import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  SupabaseService._();

  static final SupabaseService instance = SupabaseService._();

  static const urlEnv = 'SUPABASE_URL';
  static const anonKeyEnv = 'SUPABASE_ANON_KEY';

  bool _initialized = false;

  bool get isConfigured => _initialized;

  SupabaseClient? get maybeClient {
    if (!_initialized) return null;
    return Supabase.instance.client;
  }

  SupabaseClient get client {
    final current = maybeClient;
    if (current == null) {
      throw StateError(
        'Supabase nao configurado. Informe SUPABASE_URL e SUPABASE_ANON_KEY.',
      );
    }
    return current;
  }

  Future<bool> initialize() async {
    const url = String.fromEnvironment(urlEnv);
    const anonKey = String.fromEnvironment(anonKeyEnv);

    if (url.isEmpty || anonKey.isEmpty) {
      _initialized = false;
      return false;
    }

    await Supabase.initialize(url: url, anonKey: anonKey);
    _initialized = true;
    return true;
  }
}
