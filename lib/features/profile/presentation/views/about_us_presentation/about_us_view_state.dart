import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

import 'package:eram_express/features/profile/data/models/about_us_model.dart';

enum AboutUsStatus { initial, loading, loaded, error }

extension AboutUsViewStateX on AboutUsViewState {
  bool get isInitial => status == AboutUsStatus.initial;
  bool get isLoading => status == AboutUsStatus.loading;
  bool get isError => status == AboutUsStatus.error;
  bool get isLoaded => status == AboutUsStatus.loaded;
}

class AboutUsViewState {
  final AboutUsStatus status;
  final AboutUsModel? aboutUsModel;
  final String? errorMessage;
  AboutUsViewState({
    required this.status,
    this.aboutUsModel,
    this.errorMessage,
  });

  AboutUsViewState copyWith({
    AboutUsStatus? status,
    AboutUsModel? aboutUsModel,
    String ? errorMessage,
  }) {
    return AboutUsViewState(
      status: status ?? this.status,
      aboutUsModel: aboutUsModel ?? this.aboutUsModel,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AboutUsViewState &&
        other.status == status &&
        other.aboutUsModel == aboutUsModel &&
        other.errorMessage == errorMessage;
  }

  @override
  int get hashCode =>
      status.hashCode ^ aboutUsModel.hashCode ^ errorMessage.hashCode;
}
