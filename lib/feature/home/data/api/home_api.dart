import 'package:cartizy_app_nti/core/helpers/app_apis.dart';
import 'package:cartizy_app_nti/feature/home/data/dtos/request/get_products_by_category_dto.dart';
import 'package:dio/dio.dart';
import '../../../../core/helpers/network_response.dart';
import '../dtos/request/get_all_categories_response_dto.dart';

class HomeApi {
  HomeApi._();

  static HomeApi? _instance;

  static HomeApi get instance => _instance ??= HomeApi._();
  final Dio _dio = Dio();

  Future<NetworkResponse<List<GetAllCategoriesResponseDto>>>
  getAllCategories() async {
    try {
      final response = await _dio.get('${AppApis.baseUrl}/api/v1/categories/');
      return NetworkSuccess<List<GetAllCategoriesResponseDto>>(
        (response.data as List)
            .map((e) => GetAllCategoriesResponseDto.fromJson(e))
            .toList(),
      );
    } catch (e) {
      return NetworkFailure<List<GetAllCategoriesResponseDto>>(
        Exception(e.toString()),
      );
    }
  }

  Future<NetworkResponse<List<GetProductsByCategoryDto>>> getProductsByCategory(
    int categoryId,
  ) async {
    try {
      final response = await _dio.get(
        '${AppApis.baseUrl}/api/v1/categories/$categoryId/products',
      );
      return NetworkSuccess<List<GetProductsByCategoryDto>>(
        (response.data as List)
            .map((e) => GetProductsByCategoryDto.fromJson(e))
            .toList(),
      );
    } catch (e) {
      return NetworkFailure<List<GetProductsByCategoryDto>>(
        Exception(e.toString()),
      );
    }
  }
}
