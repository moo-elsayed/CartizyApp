import 'package:cartizy_app_nti/core/helpers/extentions.dart';
import 'package:cartizy_app_nti/core/theming/colors_manager.dart';
import 'package:cartizy_app_nti/core/theming/styles.dart';
import 'package:cartizy_app_nti/core/widgets/app_toasts.dart';
import 'package:cartizy_app_nti/core/widgets/custom_material_button.dart';
import 'package:cartizy_app_nti/core/entities/product_entity.dart';
import 'package:cartizy_app_nti/feature/home/presentation/managers/product_cubit/product_cubit.dart';
import 'package:cartizy_app_nti/feature/home/presentation/widgets/product_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:toastification/toastification.dart';

class ProductView extends StatelessWidget {
  const ProductView({super.key, required this.product});

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    bool hasChanges = false;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          context.pop(hasChanges);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorsManager.colorEBEBEB,
          leading: GestureDetector(
            onTap: () {
              context.pop(hasChanges);
            },
            child: Icon(Icons.arrow_back, size: 28.r),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(bottom: 16.h, right: 16.w, left: 16.w),
            child: Column(
              children: [
                ProductPageView(
                  product: product,
                  onToggleFavorite: () {
                    context.read<ProductCubit>().toggleFavoriteProduct(
                      product.id,
                    );
                    hasChanges = true;
                  },
                ),
                Gap(12.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  spacing: 40.w,
                  children: [
                    Expanded(
                      child: Text(
                        product.title,
                        overflow: TextOverflow.fade,
                        style: TextStylesManager.font16BlackRegular,
                      ),
                    ),
                    Text.rich(
                      textAlign: TextAlign.center,
                      TextSpan(
                        text: 'EGP ',
                        style: TextStylesManager.font16BlackRegular,
                        children: [
                          TextSpan(
                            text: '${product.price}',
                            style: TextStylesManager.font18BlackMedium,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Gap(32.h),
                Text(
                  product.description,
                  style: TextStylesManager.font14BlackMedium,
                ),
                Gap(42.h),
                BlocListener<ProductCubit, ProductState>(
                  listener: (context, state) {
                    if (state is AddToCartSuccess) {
                      AppToast.showToast(
                        context: context,
                        title: 'Product added to cart',
                        type: ToastificationType.success,
                      );
                    } else if (state is AddToCartFailure) {
                      AppToast.showToast(
                        context: context,
                        title: 'Product Already added',
                        type: ToastificationType.info,
                      );
                    }
                  },
                  child: CustomMaterialButton(
                    onPressed: () =>
                        context.read<ProductCubit>().addToCart(product.id),
                    text: 'Add to cart',
                    borderRadius: BorderRadius.circular(8.r),
                    color: ColorsManager.color212121,
                    maxWidth: true,
                    padding: EdgeInsetsGeometry.symmetric(vertical: 15.h),
                    textStyle: TextStylesManager.font16WhiteMedium,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
