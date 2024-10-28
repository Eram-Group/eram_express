import 'package:equatable/equatable.dart';
import 'package:eram_express/features/customer/domain/entities/customer_entity.dart';

class ProfileViewState extends Equatable {
  final CustomerEntity? currentCustomer;
  const ProfileViewState({this.currentCustomer});
  @override
  List<Object?> get props => [currentCustomer, ];

  ProfileViewState copyWith({
    CustomerEntity? currentCustomer,
    
  }) {
    return ProfileViewState(
      currentCustomer: currentCustomer ?? this.currentCustomer,
    
    );
  }
}
