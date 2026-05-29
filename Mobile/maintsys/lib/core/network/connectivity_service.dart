import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ConnectivityService {
  ConnectivityService(this._connectivity);

  final Connectivity _connectivity;

  Stream<bool> watchOnline() {
    return _connectivity.onConnectivityChanged.map(_hasConnection).distinct();
  }

  Future<bool> isOnline() async {
    final result = await _connectivity.checkConnectivity();
    return _hasConnection(result);
  }

  bool _hasConnection(List<ConnectivityResult> results) {
    return results.any((result) => result != ConnectivityResult.none);
  }
}

final connectivityServiceProvider = Provider<ConnectivityService>((ref) {
  return ConnectivityService(Connectivity());
});

final connectivityProvider = StreamProvider<bool>((ref) {
  return ref.watch(connectivityServiceProvider).watchOnline();
});
