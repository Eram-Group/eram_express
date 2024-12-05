import 'dart:io';
import 'package:equatable/equatable.dart';
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

class SupportViewState extends Equatable {
  final SupportViewStatus status;
  final String? errorMessage;
  final List<SupportTypeModel>? supportTypes;
  final SupportTypeModel? selectedReason;
  final String? detailReason;
  final File? picture;
  final bool? enabled;

  const SupportViewState({
    required this.status,
    this.errorMessage,
    this.supportTypes,
    this.selectedReason,
    this.detailReason,
    this.picture,
    this.enabled,
  });

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        supportTypes,
        selectedReason,
        detailReason,
        picture,
        enabled,
      ];

  SupportViewState copyWith({
    SupportViewStatus? status,
    String? errorMessage,
    List<SupportTypeModel>? supportTypes,
    SupportTypeModel? selectedReason,
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
}

/*

abstract class SupportViewState  {}
class SupportViewLoadingState extends SupportViewState {

}

class SupportViewInitialState extends SupportViewState {

}


class SupportViewErrorState extends SupportViewState 
{
  String errorMessage;
  SupportViewErrorState({required this.errorMessage});

}
class SupportFormErrorState extends SupportViewState {
  
  SupportFormErrorState();
}
class SupportFormSucecessState extends SupportViewState {
 
  SupportFormSucecessState();
}
class SupportLoadingState extends SupportViewState {
  
  SupportLoadingState();
}


class SupportFormLoad extends SupportViewState {
  final List<SupportTypeModel> supportTypes;
  final SupportTypeModel? selectedReason;
  final String? detailReason;
  final File? picture;
  final bool enabled;

  SupportFormLoad({
    this.supportTypes = const [],
    this.selectedReason,
    this.detailReason,
    this.picture,
    this.enabled = false,
  });

  SupportFormLoad copyWith({
    List<SupportTypeModel>? supportTypes,
    SupportTypeModel? selectedReason,
    String? detailReason,
    File? picture,
    bool? enabled,
  }) {
    return SupportFormLoad(
      supportTypes: supportTypes ?? this.supportTypes,
      selectedReason: selectedReason ?? this.selectedReason,
      detailReason: detailReason ?? this.detailReason,
      picture: picture ?? this.picture,
      enabled: enabled ?? this.enabled,
    );
  }
}
*/