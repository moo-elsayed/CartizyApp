import 'package:cartizy_app_nti/core/helpers/app_assets.dart';
import 'package:cartizy_app_nti/feature/app_section/presentation/widgets/custom_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import '../../../cart/view/cart_screen.dart';
import '../../../favorite/view/favorite_screen.dart';
import '../../../home/view/home_screen.dart';
import '../../../profile/view/profile_screen.dart';

class AppSection extends StatefulWidget {
  const AppSection({super.key});

  @override
  State<AppSection> createState() => _AppSectionState();
}

class _AppSectionState extends State<AppSection> {
  final List<Widget> _pages = [
    const HomeScreen(),
    const CartScreen(),
    const FavoriteScreen(),
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
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(index: _index, children: _pages),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        onItemTapped: _onItemTapped,
        labels: labels,
        icons: icons,
      ),
    );
  }
}
