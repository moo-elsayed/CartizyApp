import 'package:cached_network_image/cached_network_image.dart';
import 'package:cartizy_app_nti/core/entities/product_entity.dart';
import 'package:cartizy_app_nti/feature/home/presentation/managers/product_cubit/product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../core/theming/colors_manager.dart';
import '../../../onboarding/presentation/widgets/custom_animated_widget.dart';
import 'custom_favorite_icon.dart';

class ProductPageView extends StatefulWidget {
  const ProductPageView({super.key, required this.product});

  final ProductEntity product;

  @override
  State<ProductPageView> createState() => _ProductPageViewState();
}

class _ProductPageViewState extends State<ProductPageView> {
  int index = 0;
  late PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        spacing: 12.h,
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,
              onPageChanged: (value) {
                setState(() {
                  index = value;
                });
              },
              itemBuilder: (context, index) => CustomAnimatedWidget(
                delay: index,
                index: index,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24.r),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: CachedNetworkImage(
                          imageUrl: widget.product.images[index],
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) =>
                              Container(
                                color: Colors.grey,
                                width: double.infinity,
                                child: const Icon(Icons.error),
                              ),
                        ),
                      ),
                      Positioned(
                        top: 6.h,
                        right: 6.w,
                        child: CustomFavouriteIcon(
                          isFavourite: widget.product.isFavorite,
                          onChanged: () {
                            context
                                .read<ProductCubit>()
                                .markProductAsFavoriteOrNot(widget.product.id);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              itemCount: widget.product.images.length,
            ),
          ),
          SmoothPageIndicator(
            controller: _controller,
            count: widget.product.images.length,
            axisDirection: Axis.horizontal,
            effect: WormEffect(
              dotWidth: 10,
              dotHeight: 10,
              dotColor: ColorsManager.colorAAA198,
              activeDotColor: ColorsManager.color212121,
              spacing: 6.w,
            ),
          ),
        ],
      ),
    );
  }
}
