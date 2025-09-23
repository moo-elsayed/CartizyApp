import 'package:cartizy_app_nti/core/helpers/extentions.dart';
import 'package:cartizy_app_nti/core/widgets/app_toasts.dart';
import 'package:cartizy_app_nti/feature/favorite/presentation/managers/favorite_cubit/favorite_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:toastification/toastification.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/widgets/products_grid_view.dart';
import '../widgets/no_favorites_body.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Column(
        children: [
          Gap(12.h),
          Align(
            alignment: Alignment.center,
            child: Text(
              'My Favorites',
              style: TextStylesManager.font22RobotoColor212121SemiBold,
            ),
          ),
          Gap(12.h),
          BlocConsumer<FavoriteCubit, FavoriteState>(
            listener: (context, state) {
              if (state is ToggleFavorite) {
                AppToast.showToast(
                  context: context,
                  title: 'Product removed successfully',
                  type: ToastificationType.success,
                );
              }
            },
            builder: (context, state) {
              if (state is GetFavoritesSuccess || state is ToggleFavorite) {
                var favorites = context.read<FavoriteCubit>().favorites;
                if (favorites.isEmpty) {
                  return const FavoritesPlaceholder(
                    text: 'There are no products in your favourite list',
                  );
                } else {
                  return Expanded(
                    child: ProductsGridView(
                      fromFavorite: true,
                      products: favorites,
                      onTap: (product) {
                        context.pushNamed(
                          Routes.productView,
                          arguments: product,
                        );
                      },
                      onToggleFavorite: (product) {
                        context.read<FavoriteCubit>().toggleFavorite(
                          product.id,
                        );
                      },
                    ),
                  );
                }
              } else if (state is GetFavoritesLoading) {
                return Expanded(
                  child: ProductsGridView(
                    loading: true,
                    onTap: (product) {},
                    onToggleFavorite: (product) {},
                  ),
                );
              } else {
                return const FavoritesPlaceholder(
                  text: 'Error, please try again later',
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
