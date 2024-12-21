import 'dart:convert';
import 'dart:io';


class EditProfileViewState {
  final String? fullName;
  final String? phoneNumber;
  final String? profilePicture;
  final File? profilePictureFile;
  final bool saving;
  EditProfileViewState(
      {this.fullName,
      this.phoneNumber,
      this.profilePicture,
      this.profilePictureFile,
      this.saving = false});

  EditProfileViewState copyWith({
    String? fullName,
    String? phoneNumber,
    String? profilePicture,
    File? profilePictureFile,
    bool? saving,
  }) {
    return EditProfileViewState(
      fullName:  fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profilePicture: profilePicture ?? this.profilePicture ,
      profilePictureFile:  profilePictureFile?? this.profilePictureFile,
      saving: saving ?? this.saving,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'profilePicture': profilePicture,
      'profilePictureFile': profilePictureFile,
      'saving': saving,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'EditProfileViewState(fullName: $fullName, phoneNumber: $phoneNumber, profilePicture: $profilePicture, profilePictureFile: $profilePictureFile, saving: $saving)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EditProfileViewState &&
        other.fullName == fullName &&
        other.phoneNumber == phoneNumber &&
        other.profilePicture == profilePicture &&
        other.profilePictureFile == profilePictureFile &&
        other.saving == saving;
  }

  @override
  int get hashCode {
    return fullName.hashCode ^
        phoneNumber.hashCode ^
        profilePicture.hashCode ^
        profilePictureFile.hashCode ^
        saving.hashCode;
  }
}
