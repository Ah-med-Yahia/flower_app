import 'package:flower_app/features/tabs/categories/domain/entities/get_category_list_entity/category_entity.dart';
import 'package:flower_app/features/tabs/categories/presentation/views/widgets/category_tab_widget.dart';
import 'package:flutter/material.dart';

class CategoryTabBar extends StatelessWidget {
  final List<CategoryEntity> categories;
  final int selectedIndex;
  final Function(int) onTabSelected;

  const CategoryTabBar({
    super.key,
    required this.categories,
    required this.selectedIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Container(
      height: screenSize.height * 0.06,
      padding: EdgeInsets.only(
        right: screenSize.width * 0.06,
        left: screenSize.width * 0.04,
      ),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (context, index) =>
            SizedBox(width: screenSize.width * 0.05),
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
