import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:eram_express/features/profile/data/models/support_type_model.dart';


enum SupportViewStatus { initial, loading, loaded, error , supportFormSuccess, supportFormError }

extension SupportViewStateX on SupportViewState {
  bool get isInitial => status == SupportViewStatus.initial;
  bool get isLoading => status == SupportViewStatus.loading;
  bool get isError => status == SupportViewStatus.error;
  bool get isLoaded => status == SupportViewStatus.loaded;
  bool get isSupportFormSuccess=>status== SupportViewStatus.supportFormSuccess;
  bool get isSupportFormError =>  status == SupportViewStatus.supportFormError;
}

class SupportViewState {
  final SupportViewStatus status;
  final String? errorMessage;
  final List<SupportTypeModel>? supportTypes;
  final SupportTypeModel? selectedReason;
  final String? detailReason;
  final File? picture;
  final bool? enabled;
  SupportViewState({
    required this.status,
    this.errorMessage,
    this.supportTypes,
    this.selectedReason,
    this.detailReason,
    this.picture,
    this.enabled,
  });

  SupportViewState copyWith({
    SupportViewStatus? status,
   String ? errorMessage,
   List<SupportTypeModel>? supportTypes,
    SupportTypeModel?selectedReason,
    String? detailReason,
    File? picture,
    bool? enabled,
  }) {
    return SupportViewState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      supportTypes: supportTypes ?? this.supportTypes,
      selectedReason: selectedReason ?? this.selectedReason,
      detailReason: detailReason ?? this.detailReason,
      picture: picture ?? this.picture,
      enabled: enabled ?? this.enabled,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is SupportViewState &&
      other.status == status &&
      other.errorMessage == errorMessage &&
      listEquals(other.supportTypes, supportTypes) &&
      other.selectedReason == selectedReason &&
      other.detailReason == detailReason &&
      other.picture == picture &&
      other.enabled == enabled;
  }

  @override
  int get hashCode {
    return status.hashCode ^
      errorMessage.hashCode ^
      supportTypes.hashCode ^
      selectedReason.hashCode ^
      detailReason.hashCode ^
      picture.hashCode ^
      enabled.hashCode;
  }
}
