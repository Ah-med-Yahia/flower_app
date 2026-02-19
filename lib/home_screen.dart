import 'package:flower_app/config/di/di.dart';
import 'package:flower_app/core/constants/app_text_constants.dart';
import 'package:flower_app/core/enums/home_nav_tab.dart';
import 'package:flower_app/core/shared/presentation/cubits/products_cubit/products_cubit.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/features/tabs/cart/presentation/cart_tab.dart';
import 'package:flower_app/features/tabs/categories/presentation/views/categories_tap.dart';
import 'package:flower_app/features/tabs/home/presentation/view/screens/home_tap.dart';
import 'package:flower_app/features/tabs/profile/profile_tap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeNavTab _currentTab = HomeNavTab.home;

  // ignore: unused_field
  String? _selectedCategoryId;

  final Map<HomeNavTab, Widget> _baseTaps = {
    HomeNavTab.cart: const CartTab(),
    HomeNavTab.profile: const ProfileTap(),
  };

  void _switchToCategories({String? categoryId}) {
    setState(() {
      _currentTab = HomeNavTab.categories;
      _selectedCategoryId = categoryId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ProductsCubit>(),
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          elevation: 0,
          backgroundColor: AppColors.background,
          onTap: (index) {
            final selectedTab = HomeNavTab.values[index];
            if (selectedTab == _currentTab) return;
            setState(() {
              _currentTab = selectedTab;
              _selectedCategoryId = null;
            });
          },
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentTab.index,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.iconGrey,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home_outlined),
              label: AppTextConstants.home,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.category_outlined),
              label: AppTextConstants.categories,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.shopping_cart_outlined),
              label: AppTextConstants.cart,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.person_outline),
              label: AppTextConstants.profile,
            ),
          ],
        ),
        body: _buildCurrentTab(),
      ),
    );
  }

  Widget _buildCurrentTab() {
    switch (_currentTab) {
      case HomeNavTab.home:
        return HomeTap(
          onNavigateToCategories: () => _switchToCategories(),
          onNavigateSelectedToCategory: (categoryId) =>
              _switchToCategories(categoryId: categoryId),
        );
      case HomeNavTab.categories:
        return CategoriesTap(id: _selectedCategoryId);
      default:
        return _baseTaps[_currentTab] ?? const SizedBox.shrink();
    }
  }
}
