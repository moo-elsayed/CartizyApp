part of 'cart_cubit.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

final class GetProductsLoading extends CartState {}

final class GetProductsSuccess extends CartState {
  GetProductsSuccess(this.products);

  final List<ProductEntity> products;
}

final class RemoveProductLoading extends CartState {}

final class RemoveProductSuccess extends CartState {}

final class RemoveProductFailure extends CartState {}
