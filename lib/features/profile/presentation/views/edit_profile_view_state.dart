import 'dart:io';

import 'package:eram_express_shared/core/api/server_expection.dart';

enum EditProfileStatus { initial, loading, loaded, error ,success }

extension EditProfileViewStateX on EditProfileViewState {
  bool get isInitial => status == EditProfileStatus.initial;
  bool get isLoading => status == EditProfileStatus.loading;
  bool get isError => status == EditProfileStatus.error;
  bool get isSuccess => status == EditProfileStatus.success;
  bool get isLoaded => status == EditProfileStatus.loaded;
}

class EditProfileViewState {
  final EditProfileStatus status;
  final String? fullName;
  final String? phoneNumber;
  final String? profilePicture;
  final File? profilePictureFile;
  final bool saving;
 final ServerException ?serverException;
  const EditProfileViewState({
    required this.status,
    this.fullName,
    this.phoneNumber,
    this.profilePicture,
    this.profilePictureFile,
    this.serverException,
    this.saving = false,
  });

  EditProfileViewState copyWith({
    EditProfileStatus? status,
    String? fullName,
    String? phoneNumber,
    String? profilePicture,
    File? profilePictureFile,
    ServerException ?serverException,
    bool? saving,
  }) {
    return EditProfileViewState(
      status: status ?? this.status,
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profilePicture: profilePicture ?? this.profilePicture,
      profilePictureFile: profilePictureFile ?? this.profilePictureFile,
      serverException: serverException??this.serverException,
      saving: saving ?? this.saving,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EditProfileViewState &&
        other.status == status &&
        other.fullName == fullName &&
        other.phoneNumber == phoneNumber &&
        other.profilePicture == profilePicture &&
        other.profilePictureFile == profilePictureFile &&
        other.saving == saving&&
        other.serverException ==serverException;
  }

  @override
  int get hashCode {
    return status.hashCode ^
        fullName.hashCode ^
        phoneNumber.hashCode ^
        profilePicture.hashCode ^
        profilePictureFile.hashCode ^
        serverException.hashCode^
        saving.hashCode;
  }


}
