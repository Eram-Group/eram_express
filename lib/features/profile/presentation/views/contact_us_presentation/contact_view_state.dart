import 'package:flutter/widgets.dart';
import '../../../data/models/contact_us_model.dart';



enum ContactUsStatus { initial, loading, loaded, error }

extension ContactViewStateX on ContactViewState {
  bool get isInitial => status == ContactUsStatus.initial;
  bool get isLoading => status == ContactUsStatus.loading;
  bool get isError => status == ContactUsStatus.error;
  bool get isLoaded => status == ContactUsStatus.loaded;
}

class ContactViewState {
  final ContactUsStatus status;
  final ContactUsModel? contactUsModel;
  final String? errorMessage;
  ContactViewState({
    required this.status,
    this.contactUsModel,
    this.errorMessage,
  });

  ContactViewState copyWith({
    ContactUsStatus? status,
    ContactUsModel? contactUsModel,
    String ? errorMessage,  
  }) {
    return ContactViewState(
      status: status ?? this.status,
      contactUsModel:
          contactUsModel ?? this.contactUsModel,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ContactViewState &&
        other.status == status &&
        other.contactUsModel == contactUsModel &&
        other.errorMessage == errorMessage;
  }

  @override
  int get hashCode =>
      status.hashCode ^ contactUsModel.hashCode ^ errorMessage.hashCode;
}
