import 'package:cached_network_image/cached_network_image.dart';
import 'package:cartizy_app_nti/core/helpers/extentions.dart';
import 'package:cartizy_app_nti/core/routing/routes.dart';
import 'package:cartizy_app_nti/feature/home/presentation/widgets/custom_favorite_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/widgets/custom_price.dart';
import '../../../../core/entities/product_entity.dart';
import '../managers/home_cubit/home_cubit.dart';

class CustomProduct extends StatefulWidget {
  const CustomProduct({super.key, required this.product});

  final ProductEntity product;

  @override
  State<CustomProduct> createState() => _CustomProductState();
}

class _CustomProductState extends State<CustomProduct> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus!.unfocus();
        context.pushNamed(Routes.productView, arguments: widget.product);
      },
      behavior: HitTestBehavior.opaque,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8.h,
        children: [
          ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(8.r),
            child: Stack(
              children: [
                CachedNetworkImage(
                  imageUrl: widget.product.images.first,
                  errorWidget:
                      (BuildContext context, String url, Object error) =>
                          Container(
                            color: Colors.grey,
                            width: double.infinity,
                            height: 155.h,
                            child: const Icon(Icons.error),
                          ),
                ),
                Positioned(
                  top: 3.h,
                  right: 3.w,
                  child: CustomFavouriteIcon(
                    isFavourite: widget.product.isFavorite,
                    onChanged: () {
                      setState(() {
                        context.read<HomeCubit>().markProductAsFavoriteOrNot(
                          widget.product.id,
                        );
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Text(
            widget.product.title,
            style: TextStylesManager.font14BlackRegular,
          ),
          CustomPrice(price: widget.product.price),
        ],
      ),
    );
  }
}
