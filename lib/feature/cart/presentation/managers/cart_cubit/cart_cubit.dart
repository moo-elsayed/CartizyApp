import 'package:cartizy_app_nti/core/entities/product_entity.dart';
import 'package:cartizy_app_nti/feature/cart/domain/use_cases/get_products_use_case.dart';
import 'package:cartizy_app_nti/feature/cart/domain/use_cases/remove_product_use_case.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit(this._getProductsUseCase, this._removeProductUseCase)
    : super(CartInitial());

  final GetProductsUseCase _getProductsUseCase;
  final RemoveProductUseCase _removeProductUseCase;

  void getProducts() {
    emit(GetProductsLoading());
    List<ProductEntity> products = _getProductsUseCase.call();
    emit(GetProductsSuccess(products));
  }

  Future<void> removeProduct(ProductEntity product) async {
    emit(RemoveProductLoading());
    var result = await _removeProductUseCase.call(product);
    if (!result) {
      emit(RemoveProductFailure());
      return;
    }
    emit(RemoveProductSuccess());
  }
}
