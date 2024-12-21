import 'package:equatable/equatable.dart';
import '../../../../customer/data/models/customer_model.dart';

/// Enum to represent the profile status.
enum ProfileStatus { loaded, logout,initial,error }

/// Extension to simplify checking the state.
extension ProfileViewStateX on ProfileViewState {
  bool get isInitial => status == ProfileStatus.initial;
  bool get isError => status == ProfileStatus.error;
  bool get isLoaded => status == ProfileStatus.loaded;
  bool get isLogOut=> status == ProfileStatus.logout;
}

/// ProfileViewState class representing the state of the profile view.
class ProfileViewState extends Equatable {
  final ProfileStatus status;
  final CustomerModel? currentCustomer;

  const ProfileViewState({
    required this.status,
    this.currentCustomer,
  });

  @override
  List<Object?> get props => [status, currentCustomer];

  ProfileViewState copyWith({
    ProfileStatus? status,
    CustomerModel? currentCustomer,
  }) {
    return ProfileViewState(
      status: status ?? this.status,
      currentCustomer: currentCustomer ?? this.currentCustomer,
    );
  }
}
