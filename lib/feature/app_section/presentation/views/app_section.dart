import 'package:cartizy_app_nti/core/helpers/app_assets.dart';
import 'package:cartizy_app_nti/feature/app_section/presentation/widgets/custom_bottom_navigation_bar.dart';
import 'package:cartizy_app_nti/feature/cart/presentation/managers/cart_cubit/cart_cubit.dart';
import 'package:cartizy_app_nti/feature/cart/presentation/views/cart_view.dart';
import 'package:cartizy_app_nti/feature/home/presentation/managers/home_cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../favorite/presentation/managers/favorite_cubit/favorite_cubit.dart';
import '../../../favorite/presentation/views/favorite_view.dart';
import '../../../home/presentation/views/home_view.dart';
import '../../../profile/view/profile_screen.dart';

class AppSection extends StatefulWidget {
  const AppSection({super.key});

  @override
  State<AppSection> createState() => _AppSectionState();
}

class _AppSectionState extends State<AppSection> {
  final List<Widget> _pages = [
    const HomeView(),
    const CartView(),
    const FavoriteView(),
    const ProfileScreen(),
  ];

  final List<String> labels = ['Home', 'Cart', 'Favorite', 'Account'];
  final List<String> icons = [
    AppAssets.iconHome,
    AppAssets.iconCart,
    AppAssets.iconFavorite,
    AppAssets.iconProfile,
  ];

  int _index = 0;

  _onItemTapped(index) {
    _index = index;
    if (index == 0) {
      context.read<HomeCubit>().clear();
      context.read<HomeCubit>().getAllCategories();
    }
    if (index == 1) {
      context.read<CartCubit>().getProducts();
    } else if (index == 2) {
      context.read<FavoriteCubit>().getFavorites();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        // child: IndexedStack(index: _index, children: _pages),
        child: _pages[_index],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        onItemTapped: _onItemTapped,
        labels: labels,
        icons: icons,
      ),
    );
  }
}
