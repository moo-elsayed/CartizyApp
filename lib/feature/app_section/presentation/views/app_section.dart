import 'package:cartizy_app_nti/core/helpers/app_assets.dart';
import 'package:cartizy_app_nti/feature/app_section/presentation/widgets/custom_bottom_navigation_bar.dart';
import 'package:cartizy_app_nti/feature/cart/presentation/managers/cart_cubit/cart_cubit.dart';
import 'package:cartizy_app_nti/feature/cart/presentation/views/cart.dart';
import 'package:cartizy_app_nti/feature/home/presentation/managers/home_cubit/home_cubit.dart';
import 'package:cartizy_app_nti/feature/profile/presentation/views/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../favorite/presentation/managers/favorite_cubit/favorite_cubit.dart';
import '../../../favorite/presentation/views/favorite.dart';
import '../../../home/presentation/views/home.dart';
import '../../../profile/presentation/managers/profile_cubit/profile_cubit.dart';

class AppSection extends StatefulWidget {
  const AppSection({super.key});

  @override
  State<AppSection> createState() => _AppSectionState();
}

class _AppSectionState extends State<AppSection> {
  final List<Widget> _pages = [
    const Home(),
    const Cart(),
    const Favorite(),
    const Profile(),
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
    _actionDependOnIndex(index);
    setState(() {});
  }

  void _actionDependOnIndex(index) {
    switch (index) {
      case 0:
        context.read<HomeCubit>().clear();
        context.read<HomeCubit>().getAllCategories();
      case 1:
        context.read<CartCubit>().getProducts();
      case 2:
        context.read<FavoriteCubit>().getFavorites();
      case 3:
        context.read<ProfileCubit>().getProfile();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _pages[_index]),
      bottomNavigationBar: CustomBottomNavigationBar(
        onItemTapped: _onItemTapped,
        labels: labels,
        icons: icons,
      ),
    );
  }
}
