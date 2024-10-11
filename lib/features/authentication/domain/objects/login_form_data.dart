import 'package:equatable/equatable.dart';

class LoginFormData extends Equatable {
  final String phoneNumber;
  const LoginFormData({
    required this.phoneNumber,
  });
  @override
  List<Object> get props => [phoneNumber];
}
