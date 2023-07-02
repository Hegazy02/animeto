import 'package:animeto/data/models/anime_model.dart';

abstract class SearchBarState {}

class SearchBarNotActive extends SearchBarState {}

class SearchBarActive extends SearchBarState {
  List<AnimeModel> searchedAnimes = [];
  SearchBarActive({required this.searchedAnimes});
}

class EmptySearchBar extends SearchBarState {
  List<AnimeModel> allAnimes = [];
  EmptySearchBar({required this.allAnimes});
}
