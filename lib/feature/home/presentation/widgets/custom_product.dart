import 'package:cached_network_image/cached_network_image.dart';
import 'package:cartizy_app_nti/core/helpers/extentions.dart';
import 'package:cartizy_app_nti/core/routing/routes.dart';
import 'package:cartizy_app_nti/feature/home/presentation/widgets/custom_favorite_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theming/styles.dart';
import '../../domain/entities/product_entity.dart';

class CustomProduct extends StatelessWidget {
  const CustomProduct({super.key, required this.product});

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.pushNamed(Routes.productView, arguments: product),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8.h,
        children: [
          ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(8.r),
            child: Stack(
              children: [
                CachedNetworkImage(
                  imageUrl: product.images.first,
                  errorWidget: (BuildContext context, String url, Object error) =>
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
                  child: const CustomFavouriteIcon(),
                ),
              ],
            ),
          ),
          Text(product.title, style: TextStylesManager.font14BlackRegular),
          Text.rich(
            textAlign: TextAlign.center,
            TextSpan(
              text: 'EGP ',
              style: TextStylesManager.font14BlackRegular,
              children: [
                TextSpan(
                  text: '${product.price}',
                  style: TextStylesManager.font16BlackMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
