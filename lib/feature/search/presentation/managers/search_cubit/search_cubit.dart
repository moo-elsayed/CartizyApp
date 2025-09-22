import 'package:cartizy_app_nti/feature/search/domain/use_cases/search_products_use_case.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/entities/product_entity.dart';
import '../../../../../core/helpers/network_response.dart';
part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this._searchProductsUseCase) : super(SearchInitial());

  final SearchProductsUseCase _searchProductsUseCase;

  Future<void> searchProducts(String query) async {
    emit(SearchLoading());
    final result = await _searchProductsUseCase.call(query);
    switch (result) {
      case NetworkSuccess<List<ProductEntity>>():
        emit(SearchSuccess(result.data ?? []));
      case NetworkFailure<List<ProductEntity>>():
        emit(SearchFailure(result.exception.toString()));
    }
  }
}
