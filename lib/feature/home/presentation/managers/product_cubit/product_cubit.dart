import 'package:cartizy_app_nti/feature/home/domain/use_cases/add_product_to_cart_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit(this._addProductToCartUseCase) : super(ProductInitial());

  final AddProductToCartUseCase _addProductToCartUseCase;

  void addToCart(int productId) {
    emit(AddToCartLoading());
    bool result = _addProductToCartUseCase.call(productId);
    if (result) {
      emit(AddToCartSuccess());
    } else {
      emit(AddToCartFailure());
    }
  }
}
