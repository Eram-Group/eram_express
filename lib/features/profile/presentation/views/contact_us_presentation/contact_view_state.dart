import 'package:equatable/equatable.dart';
import 'package:eram_express/features/profile/data/models/about_us_model.dart';
import 'package:eram_express/features/profile/data/models/contact_us_local_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/models/contact_us_model.dart';

abstract class ContactViewState extends Equatable {
  const ContactViewState();

  @override
  List<Object?> get props => [];
}

class ContactViewLoadedState extends ContactViewState {
  final ContactUsModel contactUsViewModel;

  ContactViewLoadedState(this.contactUsViewModel);

  @override
  List<Object?> get props => [contactUsViewModel];
}

class ContactViewLoadingState extends ContactViewState {}
class ContactViewErrorState extends ContactViewState {
  final String errormesseg;

  ContactViewErrorState({required this.errormesseg
  });
}

class ContactViewStateViewErrorState extends ContactViewState {}
