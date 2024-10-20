import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'complete_profile_view_state.freezed.dart';

@freezed
abstract class CompleteProfileViewState with _$CompleteProfileViewState {
  const CompleteProfileViewState._();
  factory CompleteProfileViewState({
    File? profilePicture,
    @Default('') String fullName,
    @Default(false) bool saving,
  }) = _CompleteProfileViewState;

  bool get saveButtonLoading => saving;
  bool get saveButtonEnabled => !saveButtonLoading && fullName.isNotEmpty;
  bool get profilePictureEnabled => !saveButtonLoading;
  bool get fullNameEnabled => !saveButtonLoading;
}
