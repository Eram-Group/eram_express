import 'dart:io';

class CompleteProfileViewState {
  final File? profilePicture;
  final String fullName;
  final bool saving;

  CompleteProfileViewState({
    this.profilePicture,
    this.fullName = '',
    this.saving = false,
  });

  bool get saveButtonLoading => saving;
  bool get saveButtonEnabled => !saveButtonLoading && fullName.isNotEmpty;
  bool get profilePictureEnabled => !saveButtonLoading;
  bool get fullNameEnabled => !saveButtonLoading;

  CompleteProfileViewState copyWith({
    File? profilePicture,
    String? fullName,
    bool? saving,
  }) {
    return CompleteProfileViewState(
      profilePicture: profilePicture ?? this.profilePicture,
      fullName: fullName ?? this.fullName,
      saving: saving ?? this.saving,
    );
  }
}
