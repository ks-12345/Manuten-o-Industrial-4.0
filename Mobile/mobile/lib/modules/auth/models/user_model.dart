import 'package:isar/isar.dart';

part 'user_model.g.dart';

enum UserRole { admin, supervisor, technician }

@collection
class UserModel {
  Id id = Isar.autoIncrement;

  late String name;
  late String username;

  // Offline-first: senha apenas para demonstração local (mock)
  late String password;

  @Enumerated(EnumType.name)
  late UserRole role;

  DateTime createdAt = DateTime.now();
}
