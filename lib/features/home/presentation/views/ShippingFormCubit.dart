
import 'package:flutter_bloc/flutter_bloc.dart';

import 'ShippingFormState.dart';

class ShippingFormCubit extends Cubit<ShippingFormState> {
  ShippingFormCubit() : super(ShippingFormState());

  void setPickup(String pickup) {
    emit(state.copyWith(pickup: pickup));
  }

  void setDestination(String destination) {
    emit(state.copyWith(destination: destination));
  }

  void setLoadType(String loadType) {
    emit(state.copyWith(loadType: loadType));
  }

  void setTruckSize(String truckSize) {
    emit(state.copyWith(truckSize: truckSize));
  }

  void setPickupDate(DateTime pickupDate) {
    emit(state.copyWith(pickupDate: pickupDate));
  }
}