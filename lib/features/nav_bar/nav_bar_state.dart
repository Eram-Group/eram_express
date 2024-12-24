

enum NavigationTab { home, profile }

class NavBarState {
  final NavigationTab currentTab;
  NavBarState({
    required this.currentTab,
  });
  
  

  NavBarState copyWith({
    NavigationTab? currentTab,
  }) {
    return NavBarState(
      currentTab: currentTab ?? this.currentTab,
    );
  }



  @override
  String toString() => 'NavBarState(currentTab: $currentTab)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is NavBarState &&
      other.currentTab == currentTab;
  }

  @override
  int get hashCode => currentTab.hashCode;
}
