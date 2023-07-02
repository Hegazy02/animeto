import 'package:animeto/bussiness_logic/cubit/search_bar/search_bar_state.dart';
import 'package:animeto/data/models/anime_model.dart';
import 'package:animeto/data/repository/Searched_animes_repo.dart';
import 'package:animeto/data/web_services/dio_web_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchBarCubit extends Cubit<SearchBarState> {
  bool isActive = false;
  List<AnimeModel> searchedAnimes = [];
  List<AnimeModel> allAnimes = [];
  SearchedAnimesRepo searchedAnimesRepo = SearchedAnimesRepo(dioApi: DioApi());
  int searchPage = 1;
  ScrollController controller = ScrollController();
  bool isLoadingMore = false;

  late String searchValue;
  SearchBarCubit() : super(SearchBarNotActive()) {
    controller.addListener(() {
      getMoreAnimes();
    });
  }
  changeSearchBarState({required bool isActive}) {
    this.isActive = isActive;
    if (isActive == false) {
      emit(SearchBarNotActive());
    } else {
      emit(EmptySearchBar(allAnimes: allAnimes));
    }
  }

  changeList(
      {required String value, required List<AnimeModel> searchedAnimes}) {
    return searchedAnimes
        .where((element) => element.title.toLowerCase().startsWith(value))
        .toList();
  }

  emptySearch({required List<AnimeModel> allAnimes}) {
    emit(EmptySearchBar(allAnimes: allAnimes));
  }

  getSearchedAnime({required String searchValue}) {
    searchPage = 1;
    searchedAnimesRepo
        .getSearchedAnimes(searchPage: searchPage, searchValue: searchValue)
        .then((animes) {
      searchedAnimes = animes;
      emit(SearchBarActive(searchedAnimes: searchedAnimes));
    });
  }

  getMoreAnimes() {
    if (controller.position.pixels == controller.position.maxScrollExtent) {
      isLoadingMore = true;

      searchPage++;
      searchedAnimesRepo
          .getSearchedAnimes(searchPage: searchPage, searchValue: searchValue)
          .then((List<AnimeModel> searchedAnimes) {
        if (searchedAnimes.isEmpty) {
          isLoadingMore = false;
        }
        searchedAnimes =
            changeList(value: searchValue, searchedAnimes: searchedAnimes);

        this.searchedAnimes = [...this.searchedAnimes, ...searchedAnimes];

        emit(SearchBarActive(searchedAnimes: this.searchedAnimes));
      });
    }
  }

  @override
  void onChange(change) {
    print(change);
    super.onChange(change);
  }
}
