import 'package:eram_express/features/profile/data/models/support_type_model.dart';
import 'package:eram_express_shared/core/utils/logger.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repositories/profile_repository_impl.dart';
import '../../objacts/support_form.dart';
import 'support_view_state.dart';

class SupportViewModel extends Cubit<SupportViewState> {
  final ProfileRepository _profileRepository;

  SupportViewModel({required ProfileRepository profileRepository})
      : _profileRepository = profileRepository,
        super(const SupportViewState(status: SupportViewStatus.initial));

  Future<void> getSupportTypes() async {
    try {
      final result = await _profileRepository.getSupportType();
      logger.debug(result.length.toString());
      emit(state.copyWith(
          status: SupportViewStatus.loaded, supportTypes: result));
    } catch (e) {
      emit(state.copyWith(
          status: SupportViewStatus.error,
          errorMessage: "Error in loading support types"));
    }
  }

  void onSelectReasonClicked(SupportTypeModel? selectedReason) {
    {
      emit(state.copyWith(selectedReason: selectedReason));
    }
  }

  void onDescriptionClicked(String description) {
    {
      emit(state.copyWith(detailReason: description));
    }
  }

  bool enabledbutton() {
    return state.selectedReason != null && state.detailReason != null
        ? true
        : false;
  }

  Future<void> onSubmitClicked(BuildContext context) async {
    SupportForm supportForm = SupportForm(
        selectedReason: state.selectedReason,
        detailReason: state.detailReason,
        picture: state.picture);

    try {
      await _profileRepository.postSupportForm(supportForm);
      emit(state.copyWith(status: SupportViewStatus.supportFormSuccess));
    } catch (e) {
      emit(state.copyWith(status: SupportViewStatus.supportFormError));
    }
  }
}
