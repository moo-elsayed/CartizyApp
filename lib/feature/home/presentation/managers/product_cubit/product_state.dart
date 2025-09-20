part of 'product_cubit.dart';

sealed class ProductState {}

final class ProductInitial extends ProductState {}

final class AddToCartLoading extends ProductState {}

final class AddToCartSuccess extends ProductState {}

final class AddToCartFailure extends ProductState {}
