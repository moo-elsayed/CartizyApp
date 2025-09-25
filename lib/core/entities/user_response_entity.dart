import 'package:hive/hive.dart';

part 'user_response_entity.g.dart';

@HiveType(typeId: 2)
class UserResponseEntity {
  const UserResponseEntity({
    this.id = 0,
    this.email = '',
    this.password = '',
    this.name = '',
    this.role = '',
    this.avatar = '',
  });

  @HiveField(0)
  final int id;
  @HiveField(1)
  final String email;
  @HiveField(2)
  final String password;
  @HiveField(3)
  final String name;
  @HiveField(4)
  final String role;
  @HiveField(5)
  final String avatar;
}
