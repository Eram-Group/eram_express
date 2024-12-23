
import 'dart:convert';

import 'package:flutter/widgets.dart';

import '../../../../customer/data/models/customer_model.dart';

/// Enum to represent the profile status.
enum ProfileStatus { loaded, logout,initial,error ,loading }

/// Extension to simplify checking the state.
extension ProfileViewStateX on ProfileViewState {
  bool get isInitial => status == ProfileStatus.initial;
  bool get isError => status == ProfileStatus.error;
  bool get isLoaded => status == ProfileStatus.loaded;
  bool get isLogOut=> status == ProfileStatus.logout;
  bool get isLoading => status == ProfileStatus.loading;
}

class ProfileViewState {
  final ProfileStatus status;
  final CustomerModel? currentCustomer;
  ProfileViewState({
    required this.status,
    this.currentCustomer,
  });

  ProfileViewState copyWith({
    ProfileStatus? status,
   CustomerModel? currentCustomer,
  }) {
    return ProfileViewState(
      status: status ?? this.status,
      currentCustomer: currentCustomer ?? this.currentCustomer,
    );
  }

  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ProfileViewState &&
      other.status == status &&
      other.currentCustomer == currentCustomer;
  }

  @override
  int get hashCode => status.hashCode ^ currentCustomer.hashCode;
}
