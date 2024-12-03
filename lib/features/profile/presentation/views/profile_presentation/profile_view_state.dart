import 'package:equatable/equatable.dart';

import '../../../../customer/data/models/customer_model.dart';

class ProfileViewState extends Equatable {
  final CustomerModel? currentCustomer;
  const ProfileViewState({this.currentCustomer});
  @override
  List<Object?> get props => [currentCustomer, ];

  ProfileViewState copyWith({
    CustomerModel? currentCustomer,
    
  }) {
    return ProfileViewState(
      currentCustomer: currentCustomer ?? this.currentCustomer,
    
    );
  }
}
