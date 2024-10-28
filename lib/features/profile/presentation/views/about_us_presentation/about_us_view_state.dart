import 'package:equatable/equatable.dart';
import 'package:eram_express/features/profile/data/models/about_us_model.dart';

abstract class AboutUsViewState extends Equatable {
  const AboutUsViewState();

  @override
  List<Object?> get props => [];
}

class AboutUsViewLoadedState extends AboutUsViewState {
  final AboutUsModel aboutUsModel;

  AboutUsViewLoadedState(this.aboutUsModel);

  @override
  List<Object?> get props => [aboutUsModel];
}

class AboutUsViewLoadingState extends AboutUsViewState {}

class AboutUsViewErrorState extends AboutUsViewState {}
