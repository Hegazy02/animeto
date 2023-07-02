import 'package:animeto/data/models/anime_model.dart';
import 'package:animeto/data/web_services/dio_web_services.dart';

class AllAnimeRepo {
  final DioApi dioApi;
  AllAnimeRepo({required this.dioApi});
  Future<List<AnimeModel>> getAllAnime({required int page}) async {
    final List<dynamic> allAnimes = await dioApi.get("anime?page=$page&limit=25");
    return allAnimes.map((anime) => AnimeModel.fromJson(anime)).toList();

  }
}
