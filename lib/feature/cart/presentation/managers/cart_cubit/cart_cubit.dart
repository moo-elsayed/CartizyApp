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
  List<ProductEntity> products = [];
  late int totalPrice;

  void getProducts() {
    emit(GetProductsLoading());
    products = _getProductsUseCase.call();
    totalPrice = _getTotalPrice();
    emit(GetProductsSuccess());
  }

  Future<void> removeProduct(int productId) async {
    emit(RemoveProductLoading());
    var result = await _removeProductUseCase.call(productId);
    if (!result) {
      emit(RemoveProductFailure());
      return;
    }
    products.removeWhere((element) => element.id == productId);
    emit(RemoveProductSuccess());
  }

  void editTotalPrice({required int currentSum, required int previousSum}) {
    totalPrice -= previousSum;
    totalPrice += currentSum;
    emit(EditTotalPrice());
  }

  int _getTotalPrice() => products.isEmpty
      ? 0
      : products
            .map((e) => e.price)
            .reduce((value, element) => value + element);

  int editTotalPriceWhenRemoval({required int count, required int productPrice}) =>
      totalPrice -= count * productPrice;
}
