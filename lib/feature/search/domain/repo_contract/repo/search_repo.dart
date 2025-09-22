import 'package:cartizy_app_nti/core/entities/product_entity.dart';
import '../../../../../core/helpers/network_response.dart';

abstract class SearchRepo {
  Future<NetworkResponse<List<ProductEntity>>> getAllProducts();
}
