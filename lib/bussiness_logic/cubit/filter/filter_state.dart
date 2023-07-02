import 'package:animeto/data/models/anime_model.dart';

abstract class FilterState {}

class FilterInitial extends FilterState {}

class Filtered extends FilterState {
  List<AnimeModel> filteredAnimes = [];
  Filtered({
    required this.filteredAnimes,
  });
}
