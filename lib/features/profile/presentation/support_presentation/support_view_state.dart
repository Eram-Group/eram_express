 import 'dart:io';
import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:eram_express/features/profile/data/models/support_type_model.dart';
import 'package:eram_express/features/profile/domain/entities/support_type_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

abstract class SupportViewState  {}
class SupportViewloadingState extends SupportViewState {

}

class SupportViewintalState extends SupportViewState {

}


class SupportViewErrorState extends SupportViewState 
{
  String errormessege;
  SupportViewErrorState({required this.errormessege});

}
class SupportLoadingState extends SupportViewState {
  
  SupportLoadingState();
}


class SupportFormLoad extends SupportViewState {
  final List<SupportTypeEntity> supportTypes;
  final SupportTypeEntity? selectedReason;
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
    List<SupportTypeEntity>? supportTypes,
    SupportTypeEntity? selectedReason,
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
