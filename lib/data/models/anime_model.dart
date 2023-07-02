class AnimeModel {
  String title;
  String image;
  List<Genres> genres;
  Trailer? trailer;
  String episodes;
  Status status;
  String rating;
  String duration;
  var score;
  var rank;
  String year;
  String synopsis;
  AnimeModel({
    required this.title,
    required this.image,
    required this.genres,
    required this.trailer,
    required this.episodes,
    required this.status,
    required this.rating,
    required this.duration,
    required this.score,
    required this.rank,
    required this.year,
    required this.synopsis,
  });

  factory AnimeModel.fromJson(Map<String, dynamic> map) {
    return AnimeModel(
      title: map['title'],
      image: map['images']['jpg']['large_image_url'],
      //الي راجع ليست بس لازم ااكد للبرنامج انها ليست عشان يظهرلي الفنكنشز بتاعتها
      //عشان كدا قولت فروم ليست وكدا معايا ليست اقدر اقول بعديها دوت ماب
      genres: List.from(map['genres'])
          .map((e) => Genres.fromJson(e['name']))
          .toList(),
      trailer: Trailer.fromJson(map['trailer']),
      episodes: map['episodes'] == null ? "?" : map['episodes'].toString(),
      status: Status.changeType(map['status']),
      rating: map['rating'] ?? "Aren't rated",
      duration: map['duration'],
      score: map['score'] ?? 0,
      rank: map['rank'] ?? 0,
      year: map['year'] == null ? "?" : map['year'].toString(),
      synopsis: map['synopsis'] ?? "?",
    );
  }
}

class Trailer {
  String url;
  String image;
  Trailer({required this.url, required this.image});
  factory Trailer.fromJson(jsonData) {
    return Trailer(
        url: jsonData['url'] ?? "?",
        image: jsonData['images']['large_image_url'] ??
            "https://www.google.com/search?q=youtube+image&tbm=isch&ved=2ahUKEwih16jX5sP-AhXqmicCHf72DwwQ2-cCegQIABAA&oq=youtube&gs_lcp=CgNpbWcQARgBMgcIABCKBRBDMgcIABCKBRBDMgcIABCKBRBDMgcIABCKBRBDMgcIABCKBRBDMgcIABCKBRBDMgcIABCKBRBDMgoIABCKBRCxAxBDMgcIABCKBRBDMgcIABCKBRBDOgQIIxAnOgUIABCABDoICAAQsQMQgwE6CAgAEIAEELEDUOMJWNUdYL02aAFwAHgAgAGLAYgBiQmSAQMwLjmYAQCgAQGqAQtnd3Mtd2l6LWltZ8ABAQ&sclient=img&ei=SSJHZOGOD-q1nsEP_u2_YA&bih=657&biw=967#imgrc=rwZCQXbYR5vdBM");
  }
}

class Genres {
  String type;

  Genres({
    required this.type,
  });
  factory Genres.fromJson(String jsonData) {
    return Genres(type: jsonData);
  }
}

class Status {
  String state;

  Status({
    required this.state,
  });
  factory Status.changeType(String data) {
    if (data == 'Finished Airing') {
      return Status(state: "Finished");
    } else if (data == 'Not yet aired') {
      return Status(state: "Not yet");
    } else if (data == 'Currently Airing') {
      return Status(state: "Currently");
    } else {
      return Status(state: data);
    }
  }
}

void asd() {}
