import 'package:connectivity_plus/connectivity_plus.dart';

abstract interface class ConnectivityService {
  Stream<bool> watchOnline();

  Future<bool> isOnline();
}

class ConnectivityPlusService implements ConnectivityService {
  ConnectivityPlusService(this._connectivity);

  final Connectivity _connectivity;

  @override
  Future<bool> isOnline() async {
    final result = await _connectivity.checkConnectivity();
    return _hasConnection(result);
  }

  @override
  Stream<bool> watchOnline() {
    return _connectivity.onConnectivityChanged.map(_hasConnection).distinct();
  }

  bool _hasConnection(List<ConnectivityResult> results) {
    return results.any((result) => result != ConnectivityResult.none);
  }
}
