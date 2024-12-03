import 'package:either_dart/either.dart';
import 'package:eram_express/features/profile/data/models/support_type_model.dart';
import 'package:eram_express_shared/core/api/dio_api_client.dart';
import 'package:eram_express_shared/core/i18n/context_extension.dart';
import 'package:eram_express_shared/core/utils/logger.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../objacts/support_form.dart';
import '../../data/repositories/profile_repository.dart';
import 'support_view_state.dart';

class SupportViewModel extends Cubit<SupportViewState> {
  final ProfileRepository _profileRepository;

  SupportViewModel({required ProfileRepository profileRepository})
      : _profileRepository = profileRepository,
        super(SupportLoadingState());

  Future<void> getSupportTypes() async {
    final result = await _profileRepository.getSupportType();

    result.fold(
      (error) {
        emit(SupportViewErrorState(
           errorMessage: "Error in loading support types"));
      },
      (data) {
      
        emit(SupportFormLoad().copyWith(
            supportTypes: data));

      },
    );
  }

  void onSelectReasonClicked(SupportTypeModel? selectedReason) {
    {
      if (state is SupportFormLoad) {
        final currentState = state as SupportFormLoad;
        emit(currentState.copyWith(selectedReason: selectedReason));
      }
    }
  }

  void onDescreptionClicked(String description) {
    {
      if (state is SupportFormLoad) {
        final currentState = state as SupportFormLoad;
        emit(currentState.copyWith(detailReason: description));
      }
    }
  }

  bool enabledbutton() {
    if (state is SupportFormLoad) {
      final currentState = state as SupportFormLoad;
      return currentState.selectedReason != null &&
              currentState.detailReason != null
          ? true
          : false;
    }
    return false;
  }

  void onSubmitClicked(BuildContext context) {
    if (state is SupportFormLoad) {
      final currentState = state as SupportFormLoad;
      SupportForm supportForm = SupportForm(
          selectedReason: currentState.selectedReason,
          detailReason: currentState.detailReason,
          picture: currentState.picture);
      final result = _profileRepository.postSupportForm(supportForm);
      result.fold((error) => emit(SupportFormErrorState()),
          (data) => emit(SupportFormSucecessState()));
    }
  }
}
