import 'package:cartizy_app_nti/core/theming/styles.dart';
import 'package:cartizy_app_nti/feature/cart/presentation/managers/cart_cubit/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:toastification/toastification.dart';
import '../../../../core/helpers/app_assets.dart';
import '../../../../core/widgets/app_toasts.dart';
import '../widgets/cart_body_widget.dart';
import '../widgets/empty_cart_widget.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
      child: Column(
        children: [
          Text(
            'My Cart',
            style: TextStylesManager.font22RobotoColor212121SemiBold,
          ),
          Gap(20.h),
          BlocConsumer<CartCubit, CartState>(
            listener: (context, state) {
              if (state is RemoveProductSuccess) {
                AppToast.showToast(
                  context: context,
                  title: 'Product removed successfully',
                  type: ToastificationType.success,
                );
              }
              if (state is RemoveProductFailure) {
                AppToast.showToast(
                  context: context,
                  title: 'Something went wrong',
                  type: ToastificationType.error,
                );
              }
            },
            builder: (context, state) {
              if (state is GetProductsLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is GetProductsSuccess || state is EditTotalPrice || state is RemoveProductSuccess) {
                if (context.read<CartCubit>().products.isEmpty) {
                  return const EmptyCartWidget(
                    description: 'your cart is empty',
                    image: AppAssets.emptyCart,
                  );
                } else {
                  return const CartBodyWidget();
                }
              }
              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }
}
