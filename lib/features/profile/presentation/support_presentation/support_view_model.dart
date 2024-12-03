import 'package:eram_express/features/profile/data/models/support_type_model.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/profile_repository_impl.dart';
import '../objacts/support_form.dart';
import 'support_view_state.dart';

class SupportViewModel extends Cubit<SupportViewState> {
  final ProfileRepository _profileRepository;

  SupportViewModel({required ProfileRepository profileRepository})
      : _profileRepository = profileRepository,
        super(SupportLoadingState());

  Future<void> getSupportTypes() async {
    try
    {
        final result = await _profileRepository.getSupportType();
        emit(SupportFormLoad().copyWith(supportTypes: result));
    }
    catch(e)
    {
       emit(SupportViewErrorState(errorMessage: "Error in loading support types"));
    }
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

  Future<void> onSubmitClicked(BuildContext context) async {
    if (state is SupportFormLoad) {
      final currentState = state as SupportFormLoad;
      SupportForm supportForm = SupportForm(
          selectedReason: currentState.selectedReason,
          detailReason: currentState.detailReason,
          picture: currentState.picture);
          (data) => emit(SupportFormSucecessState());
          try
          {
           await  _profileRepository.postSupportForm(supportForm);
            emit(SupportFormSucecessState());

          }
          catch(e)
          {
                     emit(SupportFormErrorState());
          }
    }
  }
}
