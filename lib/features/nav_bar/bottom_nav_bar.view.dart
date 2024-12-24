import 'package:eram_express/features/nav_bar/nav-bar-cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app/presentation/bottom_nav_bar.dart';
import 'nav_bar_state.dart';

class NavigationView extends StatelessWidget {

  static const String route = "/Naviagtion";
  const NavigationView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavBarCubit, NavBarState>(
      builder: (context, state) {
        return Scaffold(
          body: context.read<NavBarCubit>().getCurrentScreen(),
          bottomNavigationBar: CustomBottomNavigationBar(
            currentTab: state.currentTab,
            onTabSelected: (tab) => context.read<NavBarCubit>().setTab(tab),
          ),
        );
      },
    );
  }
}
