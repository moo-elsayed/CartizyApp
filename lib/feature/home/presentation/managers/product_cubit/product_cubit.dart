import 'package:cartizy_app_nti/feature/home/domain/use_cases/add_product_to_cart_use_case.dart';
import 'package:cartizy_app_nti/feature/home/domain/use_cases/home_toggle_favorite.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit(this._addProductToCartUseCase, this._homeToggleFavoriteUseCase)
    : super(ProductInitial());

  final AddProductToCartUseCase _addProductToCartUseCase;
  final HomeToggleFavoriteUseCase _homeToggleFavoriteUseCase;

  void addToCart(int productId) {
    emit(AddToCartLoading());
    bool result = _addProductToCartUseCase.call(productId);
    if (result) {
      emit(AddToCartSuccess());
    } else {
      emit(AddToCartFailure());
    }
  }

  void toggleFavoriteProduct(int productId) {
    _homeToggleFavoriteUseCase.call(productId);
  }
}
