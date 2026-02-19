import 'package:flower_app/features/products/occasion/domain/entities/occasion_entity.dart';
import 'package:flower_app/features/products/occasion/presentation/views/widgets/occasion_tab.dart';
import 'package:flutter/material.dart';

class OccasionTabBar extends StatelessWidget {
  final List<OccasionEntity> occasions;
  final int selectedIndex;
  final Function(int) onTabSelected;

  const OccasionTabBar({
    super.key,
    required this.occasions,
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
        left: screenSize.width * 0.03,
      ),
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: occasions.length,
        separatorBuilder: (context, index) =>
            SizedBox(width: screenSize.width * 0.05),
        itemBuilder: (context, index) {
          return OccasionTab(
            title: occasions[index].name!,
            isSelected: selectedIndex == index,
            onTap: () => onTabSelected(index),
          );
        },
      ),
    );
  }
}
