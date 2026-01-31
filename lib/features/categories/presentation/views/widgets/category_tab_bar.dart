import 'package:flutter/material.dart';
import 'package:flower_app/features/categories/domain/entities/category_entity.dart';
import 'package:flower_app/features/categories/presentation/views/widgets/category_tab.dart';

class CategoryTabBar extends StatelessWidget {
  final List<CategoryEntity> categories;
  final int selectedIndex;
  final Function(int) onTabSelected;

  const CategoryTabBar({
    Key? key,
    required this.categories,
    required this.selectedIndex,
    required this.onTabSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: screenHeight * 0.06,
      padding: EdgeInsets.only(
        right: screenWidth * 0.06,
        left: screenWidth * 0.04,
      ),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (context, index) =>
            SizedBox(width: screenWidth * 0.05),
        itemBuilder: (context, index) {
          return CategoryTab(
            title: categories[index].name!,
            isSelected: selectedIndex == index,
            onTap: () => onTabSelected(index),
          );
        },
      ),
    );
  }
}
