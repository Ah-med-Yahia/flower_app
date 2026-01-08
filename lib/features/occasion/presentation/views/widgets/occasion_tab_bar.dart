import 'package:flutter/material.dart';
import 'package:online_exam_app/features/occasion/domain/entities/occasion_entity.dart';
import 'package:online_exam_app/features/occasion/presentation/views/widgets/occasion_tab.dart';

class OccasionTabBar extends StatelessWidget {
  final List<OccasionEntity> occasions;
  final int selectedIndex;
  final Function(int) onTabSelected;

  const OccasionTabBar({
    Key? key,
    required this.occasions,
    required this.selectedIndex,
    required this.onTabSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: screenHeight * 0.09,
      padding: EdgeInsets.only(
        right: screenWidth * 0.06,
        left: screenWidth * 0.03,
      ),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: occasions.length,
        separatorBuilder: (context, index) =>
            SizedBox(width: screenWidth * 0.05),
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
