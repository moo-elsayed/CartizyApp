import 'package:cartizy_app_nti/feature/cart/presentation/managers/cart_cubit/cart_cubit.dart';
import 'package:cartizy_app_nti/feature/cart/presentation/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../../../../core/entities/product_entity.dart';
import '../../../../core/theming/colors_manager.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/widgets/custom_material_button.dart';
import '../../../../core/widgets/custom_price.dart';

class CartBodyWidget extends StatefulWidget {
  const CartBodyWidget({super.key});

  @override
  State<CartBodyWidget> createState() => _CartBodyWidgetState();
}

class _CartBodyWidgetState extends State<CartBodyWidget> {
  Map<int, int> amountOfEachProduct = {};

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          BlocBuilder<CartCubit, CartState>(
            buildWhen: (previous, current) =>
                current is EditTotalPrice || current is RemoveProductSuccess,
            builder: (context, state) {
              List<ProductEntity> products = context.read<CartCubit>().products;
              if (amountOfEachProduct.isEmpty) {
                amountOfEachProduct = Map.fromIterables(
                  products.map((e) => e.id),
                  List.generate(products.length, (index) => 1),
                );
              }
              return Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) => ProductItem(
                    key: ValueKey(products[index].id),
                    initialCount: amountOfEachProduct[products[index].id] ?? 1,
                    product: products[index],
                    onSumChanged:
                        ({
                          required currentSum,
                          required previousSum,
                          required count,
                        }) {
                          context.read<CartCubit>().editTotalPrice(
                            previousSum: previousSum,
                            currentSum: currentSum,
                          );
                          amountOfEachProduct[products[index].id] = count;
                        },
                  ),
                  physics: const BouncingScrollPhysics(),
                  separatorBuilder: (context, index) => Gap(20.h),
                  itemCount: context.read<CartCubit>().products.length,
                ),
              );
            },
          ),
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                Gap(10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: TextStylesManager.font14color212121Bold,
                    ),
                    BlocBuilder<CartCubit, CartState>(
                      builder: (context, state) {
                        return CustomPrice(
                          price: context.read<CartCubit>().totalPrice,
                        );
                      },
                    ),
                  ],
                ),
                Divider(
                  color: ColorsManager.colorC6C6C6,
                  endIndent: 3.w,
                  indent: 3.w,
                ),
                CustomMaterialButton(
                  onPressed: () {},
                  text: 'Checkout',
                  maxWidth: true,
                  color: ColorsManager.color212121,
                  borderRadius: BorderRadius.circular(8.r),
                  textStyle: TextStylesManager.font16WhiteMedium,
                  padding: EdgeInsets.symmetric(vertical: 15.h),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
