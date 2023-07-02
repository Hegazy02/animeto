import 'package:animeto/data/models/anime_model.dart';

abstract class AllAnimeState {}

class AllAnimeInitial extends AllAnimeState {}

class AllAnimeLoading extends AllAnimeState {}

class AllAnimeSuccess extends AllAnimeState {
  late List<AnimeModel> allAnimes;
  AllAnimeSuccess({required this.allAnimes});
}

class SearchedAnimeSuccess extends AllAnimeState {
  late List<AnimeModel> searched;
  SearchedAnimeSuccess({required this.searched});
}

class FilteredAnimeSuccess extends AllAnimeState {
  late List<AnimeModel> filteredAnimes;
  FilteredAnimeSuccess({required this.filteredAnimes});
}

class AllAnimeFailure extends AllAnimeState {}
