import 'package:animeto/bussiness_logic/cubit/anime/anime_state.dart';
import 'package:animeto/data/models/anime_model.dart';
import 'package:animeto/data/repository/all_anime_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllAnimeCubit extends Cubit<AllAnimeState> {
  AllAnimeRepo allAnimeRepo;
  late List<AnimeModel> allAnimes;
  ScrollController controller = ScrollController();
  bool isLoadingMore = false;
  AllAnimeCubit(this.allAnimeRepo) : super(AllAnimeInitial()) {
    controller.addListener(() {
      getMoreAnimes();
    });
  }
  int page = 1;

  getAllAnimes() {
    emit(AllAnimeLoading());
    allAnimeRepo.getAllAnime(page: page).then((List<AnimeModel> allAnimes) {
      this.allAnimes = allAnimes;
      emit(AllAnimeSuccess(allAnimes: allAnimes));
    });
  }

  getMoreAnimes() {
    if (controller.position.pixels == controller.position.maxScrollExtent) {
      isLoadingMore = true;

      page++;
      allAnimeRepo.getAllAnime(page: page).then((List<AnimeModel> allAnimes) {
        this.allAnimes = [...this.allAnimes, ...allAnimes];

        emit(AllAnimeSuccess(allAnimes: this.allAnimes));
      });
    }
  }

  searched({required List<AnimeModel> searchedAnimes}) {
    emit(SearchedAnimeSuccess(searched: searchedAnimes));
  }

  fullAnimes() {
    emit(AllAnimeSuccess(allAnimes: allAnimes));
  }

  filter({required List<AnimeModel> filteredAnimes}) {
    emit(FilteredAnimeSuccess(filteredAnimes: filteredAnimes));
  }

  @override
  void onChange(Change<AllAnimeState> change) {
    print(change);
    super.onChange(change);
  }
}
