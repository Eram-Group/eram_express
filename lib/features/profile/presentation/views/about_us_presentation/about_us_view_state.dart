import 'package:equatable/equatable.dart';
import 'package:eram_express/features/profile/data/models/about_us_model.dart';

enum AboutUsStatus 
{
  initial,
  loading,
  loaded,
  error
}

extension  AboutUsViewStateX on  AboutUsViewState {
  bool get isInitial => status == AboutUsStatus.initial;
  bool get isLoading =>status == AboutUsStatus.loading;
  bool get isError =>status == AboutUsStatus.error;
  bool get isLoaded=> status == AboutUsStatus.loaded;
}

class AboutUsViewState extends Equatable {
  final AboutUsStatus status;
  final AboutUsModel? aboutUsModel;
  final String? errorMessage;

  const AboutUsViewState({
    required this.status,
    this.aboutUsModel,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [status, aboutUsModel, errorMessage];

  AboutUsViewState copyWith({
    AboutUsStatus? status,
    AboutUsModel? aboutUsModel,
    String? errorMessage,
  }) {
    return AboutUsViewState(
      status: status ?? this.status,
      aboutUsModel: aboutUsModel ?? this.aboutUsModel,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
