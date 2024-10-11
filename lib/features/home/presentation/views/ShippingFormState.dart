
class ShippingFormState {
  final String? pickup;
  final String? destination;
  final String? loadType;
  final String? truckSize;
  final DateTime? pickupDate;

  ShippingFormState({
    this.pickup,
    this.destination,
    this.loadType,
    this.truckSize,
    this.pickupDate,
  });

  ShippingFormState copyWith({
    String? pickup,
    String? destination,
    String? loadType,
    String? truckSize,
    DateTime? pickupDate,
  }) {
    return ShippingFormState(
      pickup: pickup ?? this.pickup,
      destination: destination ?? this.destination,
      loadType: loadType ?? this.loadType,
      truckSize: truckSize ?? this.truckSize,
      pickupDate: pickupDate ?? this.pickupDate,
    );
  }
}
