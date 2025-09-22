import 'package:cached_network_image/cached_network_image.dart';
import 'package:cartizy_app_nti/core/theming/colors_manager.dart';
import 'package:cartizy_app_nti/feature/cart/presentation/managers/cart_cubit/cart_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/widgets/custom_price.dart';
import '../../../../core/entities/product_entity.dart';

class ProductItem extends StatefulWidget {
  const ProductItem({
    super.key,
    required this.product,
    required this.onSumChanged,
  });

  final ProductEntity product;
  final Function({required int previousSum, required int currentSum})
  onSumChanged;

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  int count = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorsManager.colorFAFAFA,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(8.r),
              topLeft: Radius.circular(8.r),
            ),
            child: CachedNetworkImage(
              imageUrl: widget.product.images.first,
              height: 100.h,
              width: 100.w,
              fit: BoxFit.cover,
            ),
          ),
          Gap(8.w),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 16.h,
              children: [
                Text(
                  widget.product.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStylesManager.font14color212121Regular,
                ),
                CustomPrice(price: widget.product.price),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            spacing: 16.h,
            children: [
              IconButton(
                visualDensity: VisualDensity.compact,
                highlightColor: Colors.transparent,
                onPressed: () =>
                    context.read<CartCubit>().removeProduct(widget.product.id),
                icon: Icon(
                  CupertinoIcons.clear,
                  size: 22.r,
                  color: ColorsManager.color212121,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: ColorsManager.colorF4F4F4,
                  borderRadius: BorderRadius.circular(4.w),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      highlightColor: Colors.transparent,
                      visualDensity: VisualDensity.compact,
                      onPressed: () {
                        if (count != 1) {
                          widget.onSumChanged(
                            previousSum: widget.product.price * count,
                            currentSum: widget.product.price * --count,
                          );
                        }
                      },
                      icon: Icon(
                        size: 22.r,
                        Icons.remove_circle_outline,
                        color: ColorsManager.color212121,
                      ),
                    ),
                    Text(
                      '$count',
                      style: TextStylesManager.font12color1F1F1FRegular,
                    ),
                    IconButton(
                      visualDensity: VisualDensity.compact,
                      highlightColor: Colors.transparent,
                      onPressed: () {
                        widget.onSumChanged(
                          previousSum: widget.product.price * count,
                          currentSum: widget.product.price * ++count,
                        );
                      },
                      icon: Icon(
                        size: 22.r,
                        Icons.add_circle_outline,
                        color: ColorsManager.color212121,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Gap(8.w),
        ],
      ),
    );
  }
}
