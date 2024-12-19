import 'package:equatable/equatable.dart';

import '../../../data/models/contact_us_model.dart';




enum ContactUsStatus { initial, loading, loaded, error }

extension  ContactViewStateX on  ContactViewState {
  bool get isInitial => status ==ContactUsStatus.initial;
  bool get isLoading => status ==ContactUsStatus.loading;
  bool get isError => status ==ContactUsStatus.error;
  bool get isLoaded => status ==ContactUsStatus.loaded;
}


class ContactViewState extends Equatable {
  final   ContactUsStatus  status;
  final ContactUsModel? contactUsModel;
  final String? errorMessage;

  const ContactViewState({
    required this.status,
    this.contactUsModel,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [status, contactUsModel, errorMessage];

  ContactViewState copyWith({
   ContactUsStatus ? status ,
   ContactUsModel? contactUsModel,
    String? errorMessage,
  }) {
    return ContactViewState(
      status: status ?? this.status,
      contactUsModel: contactUsModel ?? this.contactUsModel,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
