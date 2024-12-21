import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:eram_express/features/booking/data/models/booking_request_model.dart';

enum BookingRequestStatus {
  initial,
  loading,
  loaded,
  error,
  acceptBidding,
  empty
}

extension BookingRequestViewStateX on BookingRequestViewState {
  bool get isInitial => status == BookingRequestStatus.initial;
  bool get isLoading => status == BookingRequestStatus.loading;
  bool get isLoaded => status == BookingRequestStatus.loaded;
  bool get isError => status == BookingRequestStatus.error;
  bool get isEmpty => status == BookingRequestStatus.empty;
  bool get isAcceptingBid => status == BookingRequestStatus.acceptBidding;
}

class BookingRequestViewState {
  final BookingRequestStatus status;
  final List<BookingRequestModel>? bookingRequests;
  final String? errorMessage;
  BookingRequestViewState({
    required this.status,
    this.bookingRequests,
    this.errorMessage,
  });

  BookingRequestViewState copyWith({
    BookingRequestStatus? status,
    List<BookingRequestModel>? bookingRequests,
    String? errorMessage,
  }) {
    return BookingRequestViewState(
      status: status ?? this.status,
      bookingRequests: bookingRequests ?? this.bookingRequests,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BookingRequestViewState &&
        other.status == status &&
        listEquals(other.bookingRequests, bookingRequests) &&
        other.errorMessage == errorMessage;
  }

  @override
  int get hashCode =>
      status.hashCode ^ bookingRequests.hashCode ^ errorMessage.hashCode;
}
