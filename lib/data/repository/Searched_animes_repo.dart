import 'package:animeto/data/models/anime_model.dart';
import 'package:animeto/data/web_services/dio_web_services.dart';

class SearchedAnimesRepo {
  final DioApi dioApi;
  SearchedAnimesRepo({required this.dioApi});
  Future<List<AnimeModel>> getSearchedAnimes(
      {required int searchPage, required String searchValue}) async {
    final List<dynamic> searchedAnimes =
        await dioApi.get("anime?page=$searchPage&limit=25&q=$searchValue");
    return searchedAnimes.map((anime) => AnimeModel.fromJson(anime)).toList();
  }
}
