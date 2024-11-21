import 'package:either_dart/either.dart';
import 'package:eram_express_shared/core/api/dio_api_client.dart';
import 'package:eram_express_shared/core/utils/logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/support_type_entity.dart';
import '../../domain/repositories/profile_repository.dart';
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
            errormessege: "Error in loading support types"));
      },
      (data) {
        //logger.debug(data.length.toString());

        emit(SupportFormLoad().copyWith(
            supportTypes: data.map((item) => item.toEntity()).toList()));
        //logger.debug(data.length.toString());
      },
    );
  }

  void onSelectReasonClicked(SupportTypeEntity? selectedReason) {
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
}
