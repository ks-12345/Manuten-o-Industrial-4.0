abstract interface class LocalDatabaseService {
  Future<void> open();

  Future<void> close();
}

class IsarLocalDatabaseService implements LocalDatabaseService {
  @override
  Future<void> open() async {
    // Isar schemas will be registered here after the first persisted entities.
  }

  @override
  Future<void> close() async {}
}
