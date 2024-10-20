
import 'package:equatable/equatable.dart';
import '../../data/models/place_autocomplete_model/prediction.dart';

sealed class SearchState extends Equatable 
{
  const SearchState();
  @override
  List<Object> get props => [];
}

class SearchStateEmpty extends SearchState {}
class SearchStateLoading extends SearchState {}
class SearchStateError extends SearchState 
{
  const SearchStateError(this.error);
  final String error;
}
class SearchStateSuccess extends SearchState 
{
  const SearchStateSuccess(this.items);
  final List<Prediction> items;
  @override
  List<Object> get props => [items];
}




/*
class AutoCompleteSelectedPlace extends SearchState {
  const AutoCompleteSelectedPlace(this.place);
  final Place place;

  @override
  List<Object> get props => [place];
}

class AutoCompleteError extends AutoCompleteState {
  const AutoCompleteError(this.error);

  final String error;
}

*/