import 'package:eram_express/core/app_colors.dart';
import 'package:eram_express_shared/presentation/widgets/svgIcon.dart';
import 'package:flutter/material.dart';

import '../../features/nav_bar/nav_bar_state.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final NavigationTab currentTab;
  final ValueChanged<NavigationTab> onTabSelected;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentTab,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0, bottom: 0),
      child: SizedBox(
        height: 60,
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          iconSize: 25,
          unselectedItemColor: const Color(0xffA7A9B7),
          selectedItemColor: AppColor.secondaryColor,
          currentIndex: currentTab.index,
          onTap: (index) => onTabSelected(NavigationTab.values[index]),
          items: [
            BottomNavigationBarItem(
              icon: SvgIcon(
                asset: "home",
                color: currentTab == NavigationTab.home
                    ? AppColor.secondaryColor
                    : const Color(0xffA7A9B7),
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: SvgIcon(
                asset: "profile",
                color: currentTab == NavigationTab.profile
                    ? AppColor.secondaryColor
                    : const Color(0xffA7A9B7),
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
