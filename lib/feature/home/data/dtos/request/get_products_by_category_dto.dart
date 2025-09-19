import 'package:cartizy_app_nti/feature/home/data/dtos/request/get_all_categories_response_dto.dart';
import '../../../domain/entities/category_entity.dart';
import '../../../domain/entities/product_entity.dart';

class GetProductsByCategoryDto {
  GetProductsByCategoryDto({
    this.id,
    this.title,
    this.slug,
    this.price,
    this.description,
    this.category,
    this.images,
    this.creationAt,
    this.updatedAt,
  });

  int? id;
  String? title;
  String? slug;
  int? price;
  String? description;
  GetAllCategoriesResponseDto? category;
  List<String>? images;
  DateTime? creationAt;
  DateTime? updatedAt;

  GetProductsByCategoryDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    slug = json['slug'];
    price = json['price'];
    description = json['description'];
    category = json['category'] != null
        ? GetAllCategoriesResponseDto.fromJson(json['category'])
        : null;
    images = json['images'].cast<String>();
    creationAt = json['creationAt'];
    updatedAt = json['updatedAt'];
  }

  ProductEntity toEntity() => ProductEntity(
    id: id ?? 0,
    title: title ?? '',
    slug: slug ?? '',
    price: price ?? 0,
    description: description ?? '',
    category: category?.toEntity() ?? const CategoryEntity(),
    images: images ?? const [],
  );
}
