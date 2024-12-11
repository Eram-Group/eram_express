
import '../../data/models/place_auto_complete_model.dart';


enum SearchStateStatus {
  empty,
  initial,
  loading,
  error,
  success,
}

extension SearchStateX on SearchState {
  bool get isInitial => status == SearchStateStatus.initial;
  bool get isError =>
      status == SearchStateStatus.error;
  bool get isSuccess =>
      status == SearchStateStatus.success;
       bool get isLoading => status == SearchStateStatus.loading;
        bool get isEmpty => status == SearchStateStatus.empty;
}

class SearchState {
  final SearchStateStatus status;
  final String? errorMessage;
  final List<PlaceAutocompleteModel> ?recommendPlaces;

  const SearchState({
    this.status = SearchStateStatus.initial,
    this.errorMessage,
    this.recommendPlaces,
  });

  SearchState copyWith({
    SearchStateStatus? status,
    String? errorMessage,
    List<PlaceAutocompleteModel>? recommendPlaces,
  }) {
    return SearchState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      recommendPlaces: recommendPlaces ?? this.recommendPlaces,
    );
  }

  //List<Object?> get props => [status, errorMessage, recommendPlaces];
}



