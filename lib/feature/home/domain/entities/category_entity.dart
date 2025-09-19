import 'package:hive/hive.dart';
part 'category_entity.g.dart';

@HiveType(typeId: 0)
class CategoryEntity {
  const CategoryEntity({
    this.id = 0,
    this.name = '',
    this.slug = '',
    this.image = '',
  });

  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String slug;
  @HiveField(3)
  final String image;
}
