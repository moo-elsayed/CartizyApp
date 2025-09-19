import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/helpers/app_assets.dart';
import '../../../../core/theming/styles.dart';
import '../../domain/entities/product_entity.dart';

class CustomProduct extends StatelessWidget {
  const CustomProduct({super.key, required this.product});

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8.h,
      children: [
        Stack(
          alignment: Alignment.topRight,
          children: [
            ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(8.r),
              child: CachedNetworkImage(
                imageUrl: product.images.first,
                errorWidget: (BuildContext context, String url, Object error) =>
                    Container(
                      color: Colors.grey,
                      width: double.infinity,
                      height: 155.h,
                      child: const Icon(Icons.error),
                    ),
              ),
            ),
            Positioned(
              top: 6.h,
              right: 6.w,
              child: SvgPicture.asset(AppAssets.iconFavorite),
            ),
          ],
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
    );
  }
}
