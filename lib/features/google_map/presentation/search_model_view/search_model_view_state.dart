
import 'package:equatable/equatable.dart';
import '../../data/models/place_auto_complete_model.dart';

sealed class SearchState extends Equatable 
{
  const SearchState();
  @override
  List<Object> get props => [];
}

class SearchStateEmpty extends SearchState {}
class SearchStateInitial extends SearchState {}
class SearchStateLoading extends SearchState {}
class SearchStateError extends SearchState 
{
  const SearchStateError(this.error);
  final String error;
}
class SearchStateSuccess extends SearchState 
{
  const SearchStateSuccess(this.recommendPlaces);
  final List<PlaceAutocompleteModel> recommendPlaces;
  @override
  List<Object> get props => [recommendPlaces];
}

