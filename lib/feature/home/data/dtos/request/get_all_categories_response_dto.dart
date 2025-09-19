import 'package:cartizy_app_nti/feature/home/domain/entities/category_entity.dart';

class GetAllCategoriesResponseDto {
  GetAllCategoriesResponseDto({
    this.id,
    this.name,
    this.slug,
    this.image,
    this.creationAt,
    this.updatedAt,
  });

  int? id;
  String? name;
  String? slug;
  String? image;
  DateTime? creationAt;
  DateTime? updatedAt;

  factory GetAllCategoriesResponseDto.fromJson(Map<String, dynamic> json) =>
      GetAllCategoriesResponseDto(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        image: json["image"],
        creationAt: DateTime.parse(json["creationAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  CategoryEntity toEntity() => CategoryEntity(
    id: id ?? 0,
    name: name ?? '',
    slug: slug ?? '',
    image: image ?? '',
  );
}
