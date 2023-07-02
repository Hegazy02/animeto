import 'package:animeto/bussiness_logic/cubit/filter/filter_state.dart';
import 'package:animeto/data/models/anime_model.dart';
import 'package:animeto/data/repository/filter_anime_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterCubit extends Cubit<FilterState> {
  List<AnimeModel> filteredAnimes = [];
  AnimeFilterRepo animeFilterRepo;
  int searchPage = 1;
  ScrollController controller = ScrollController();
  late String filter;

  bool isLoadingMore = false;
  FilterCubit(this.animeFilterRepo) : super(FilterInitial()) {
    controller.addListener(() {
      moreFilterAnimes(filter: filter);
    });
  }
  filterAnimes({required String filter}) {
    animeFilterRepo.animeFilter(searchPage: 1, filter: filter).then((animes) {
      this.filter = filter;

      filteredAnimes = animes;

      emit(Filtered(filteredAnimes: animes));
    });
  }

  moreFilterAnimes({required String filter}) {
    if (controller.position.pixels == controller.position.maxScrollExtent) {
      isLoadingMore = true;
      searchPage++;
      animeFilterRepo
          .animeFilter(searchPage: searchPage, filter: filter)
          .then((animes) {
        filteredAnimes = [...filteredAnimes, ...animes];
        emit(Filtered(filteredAnimes: filteredAnimes));
      });
    }
  }
}
