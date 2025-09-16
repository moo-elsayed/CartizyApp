import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../cart/view/cart_screen.dart';
import '../favorite/view/favorite_screen.dart';
import '../home/view/home_screen.dart';
import '../profile/view/profile_screen.dart';

class AppSection extends StatefulWidget {
  static const String routeName = 'InitApp';

  const AppSection({super.key});

  @override
  State<AppSection> createState() => _AppSectionState();
}

class _AppSectionState extends State<AppSection> {
  List<Widget> widgetList = [
    const HomeScreen(),
    const CartScreen(),
    const FavoriteScreen(),
    const ProfileScreen(),
  ];

  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        unselectedFontSize: 13,
        selectedFontSize: 14,
        selectedItemColor: const Color(0xff212121),
        unselectedItemColor: const Color(0xff5C5C5C),
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 16,
          color: Color(0xff212121),
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 15,
          color: Color(0xff5C5C5C),
        ),
        currentIndex: index,
        onTap: (selectedIndex) {
          index = selectedIndex;
          setState(() {});
        },
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/icon-home.svg',
              height: 23,
              width: 23,
              fit: BoxFit.cover,
              colorFilter: buildColorFilter(index == 0),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/icon-cart.svg',
              height: 23,
              width: 23,
              fit: BoxFit.cover,
              colorFilter: buildColorFilter(index == 1),
            ),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/icon-favourite.svg',
              height: 23,
              width: 23,
              fit: BoxFit.cover,
              colorFilter: buildColorFilter(index == 2),
            ),
            label: ' Favorite',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/icon-profile.svg',
              height: 23,
              width: 23,
              fit: BoxFit.cover,
              colorFilter: buildColorFilter(index == 2),
            ),
            label: 'Profile',
          ),
        ],
      ),
      body: SafeArea(child: widgetList[index]),
    );
  }

  ColorFilter buildColorFilter(bool isSelected) {
    return ColorFilter.mode(
      isSelected ? const Color(0xff212121) : const Color(0xff5C5C5C),
      BlendMode.srcIn,
    );
  }
}
