import 'package:eram_express/features/home/presentation/views/home_view.dart';
import 'package:eram_express/features/profile/presentation/views/profile_presentation/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'nav_bar_state.dart';

class NavBarCubit extends Cubit<NavBarState> {
  NavBarCubit() : super(NavBarState(currentTab: NavigationTab.home));

  void setTab(NavigationTab tab) {
    emit(state.copyWith(currentTab: tab));
  }

  Widget getCurrentScreen() {
    switch (state.currentTab) {
      case NavigationTab.home:
        return const HomeView();
      case NavigationTab.profile:
        return ProfileView();
    }
  }
}
