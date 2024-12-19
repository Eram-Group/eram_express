import 'dart:io';
import 'package:equatable/equatable.dart';

class EditProfileViewState extends Equatable {
  final String? fullName;
  final String? phoneNumber;
  final String? profilePicture;
  final bool saving;

  const EditProfileViewState({
    this.fullName,
    this.phoneNumber,
    this.profilePicture,
    this.saving = false,
  });

  @override
  List<Object?> get props => [fullName, phoneNumber, profilePicture, saving];

  EditProfileViewState copyWith({
    String? fullName,
    String? phoneNumber,
    String? profilePicture,
    bool? saving,
  }) {
    return EditProfileViewState(
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profilePicture: profilePicture ?? this.profilePicture,
      saving: saving ?? this.saving,
    );
  }
}
