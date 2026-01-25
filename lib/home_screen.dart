import 'package:flower_app/core/constants/app_text_constants.dart';
import 'package:flower_app/core/enums/home_nav_tab.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/features/cart/cart_tap.dart';
import 'package:flower_app/features/categories/presentation/views/screens/categories_screen.dart';
import 'package:flower_app/features/home/presentation/views/home_tap.dart';
import 'package:flower_app/features/profile/profile_tap.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeNavTab _currentTab = HomeNavTab.home;
  final Map<HomeNavTab, Widget> _taps = {
    HomeNavTab.home: const HomeTap(),
    HomeNavTab.categories: CategoriesTap(),
    HomeNavTab.cart: const CartTap(),
    HomeNavTab.profile: const ProfileTap(),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        backgroundColor: AppColors.background,
        onTap: (index) {
          final selectedTab = HomeNavTab.values[index];
          if (selectedTab == _currentTab) return;
          setState(() {
            _currentTab = selectedTab;
          });
        },
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentTab.index,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.iconGrey,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: AppTextConstants.home,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category_outlined),
            label: AppTextConstants.categories,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: AppTextConstants.cart,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: AppTextConstants.profile,
          ),
        ],
      ),
      body: _taps[_currentTab],
    );
  }
}
