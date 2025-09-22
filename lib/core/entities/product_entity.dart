import 'package:cartizy_app_nti/feature/home/domain/entities/category_entity.dart';
import 'package:hive/hive.dart';
part 'product_entity.g.dart';

@HiveType(typeId: 1)
class ProductEntity {
  ProductEntity({
    this.id = 0,
    this.title = '',
    this.slug = '',
    this.price = 0,
    this.description = '',
    this.category = const CategoryEntity(),
    this.images = const [],
    this.isFavorite = false,
    this.inCart = false
  });

  @HiveField(0)
  final int id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String slug;
  @HiveField(3)
  final int price;
  @HiveField(4)
  final String description;
  @HiveField(5)
  final CategoryEntity category;
  @HiveField(6)
  final List<String> images;
  @HiveField(7)
  bool isFavorite;
  @HiveField(8)
  bool inCart;
}
