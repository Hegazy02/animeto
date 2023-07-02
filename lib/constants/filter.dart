enum FilterByType { tv, ova, movie, special, ona, music }

enum FilterByStatus { airing, completed, complete, to_be_aired, tba, upcoming }

enum FilterByRate { g, pg, pg13, r17, r, rx }

enum FilterByOrder {
  title,
  start_date,
  end_date,
  score,
  type,
  members,
  episodes,
  rating
}

enum FilterBySort {
  ascending,
  descending,
}

class filtersLists {
  static List<String> filterKeys = [
    "type",
    "genres",
    "rating",
    "order_by",
    "status"
  ];
  static List<String> filterByGenres = [
    "all",
    'Action',
    'Adventure',
    'Cars',
    'Comedy',
    'Avante Garde',
    'Demons',
    'Mystery',
    'Drama',
    'Ecchi',
    'Fantasy',
    'Game',
    'Hentai',
    'Historical',
    'Horror',
    'Kids',
    'Martial Arts',
    'Mecha',
    'Music',
    'Parody',
    'Samurai',
    'Romance',
    'School',
    'Sci Fi',
    'Shoujo',
    'Girls Love',
    'Shounen',
    'Boys Love',
    'Space',
    'Sports',
    'Super Power',
    'Vampire',
    'Harem',
    'Slice Of Life',
    'Supernatural',
    'Military',
    'Police',
    'Psychological',
    'Suspense',
    'Seinen',
    'Josei'
  ];
  static List<String> filterByType = [
    "all",
    FilterByType.tv.name,
    FilterByType.movie.name,
    FilterByType.ova.name,
    FilterByType.special.name,
    FilterByType.ona.name,
    FilterByType.music.name,
  ];
  static List<String> filterByRate = [
    "all",
    FilterByRate.g.name,
    FilterByRate.pg.name,
    FilterByRate.pg13.name,
    FilterByRate.r.name,
    FilterByRate.r17.name,
    FilterByRate.rx.name,
  ];
  static List<String> filterByOrder = [
    "all",
    FilterByOrder.rating.name,
    FilterByOrder.score.name,
    FilterByOrder.title.name,
    FilterByOrder.type.name,
    FilterByOrder.start_date.name,
    FilterByOrder.end_date.name,
    FilterByOrder.episodes.name,
  ];
  static List<String> filterByStatus = [
    "all",
    FilterByStatus.airing.name,
    FilterByStatus.complete.name,
    FilterByStatus.tba.name,
    FilterByStatus.to_be_aired.name,
    FilterByStatus.upcoming.name,
  ];
}
