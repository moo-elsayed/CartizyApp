import 'package:cached_network_image/cached_network_image.dart';
import 'package:cartizy_app_nti/feature/home/presentation/widgets/custom_favorite_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/widgets/custom_price.dart';
import '../../../../core/entities/product_entity.dart';

class CustomProduct extends StatefulWidget {
  const CustomProduct({
    super.key,
    required this.product,
    required this.onTap,
    required this.onToggleFavorite,
  });

  final ProductEntity product;
  final void Function() onTap;
  final void Function() onToggleFavorite;

  @override
  State<CustomProduct> createState() => _CustomProductState();
}

class _CustomProductState extends State<CustomProduct> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
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
                  height: 155.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
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
                        widget.onToggleFavorite();
                    },
                  ),
                ),
              ],
            ),
          ),
          Text(
            widget.product.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStylesManager.font14BlackRegular,
          ),
          CustomPrice(price: widget.product.price),
        ],
      ),
    );
  }
}
