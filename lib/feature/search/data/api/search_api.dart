import 'package:dio/dio.dart';
import '../../../../core/dtos/get_products_dto.dart';
import '../../../../core/helpers/app_apis.dart';
import '../../../../core/helpers/network_response.dart';

class SearchApi {
  SearchApi._();

  static SearchApi? _instance;

  static SearchApi get instance => _instance ??= SearchApi._();

  final Dio _dio = Dio();

  Future<NetworkResponse<List<GetProductsDto>>> getAllProducts() async {
    try {
      final response = await _dio.get('${AppApis.baseUrl}/api/v1/products/');
      return NetworkSuccess<List<GetProductsDto>>(
        (response.data as List).map((e) => GetProductsDto.fromJson(e)).toList(),
      );
    } catch (e) {
      return NetworkFailure<List<GetProductsDto>>(Exception(e.toString()));
    }
  }
}
