import 'package:intl/intl.dart';

class MovieDetail {
  final bool isAdult;
  final String backdropPath;
  final String originalTitle;
  final String overview;
  final String title;
  final String releaseDate;
  final double voteAverage;
  final List<Map<String, dynamic>> genres;
  final String key;

  MovieDetail({
    required this.isAdult,
    required this.backdropPath,
    required this.originalTitle,
    required this.overview,
    required this.title,
    required this.releaseDate,
    required this.voteAverage,
    required this.genres,
    required this.key,
  });

  factory MovieDetail.fromJson(Map<String, dynamic> json) {
    String videoKey = '';
    if (json['videos'] != null &&
        json['videos']['results'] != null &&
        json['videos']['results'].isNotEmpty) {
      videoKey = json['videos']['results'][0]['key'] ?? '';
    }

    String defaultBackdropPath = 'lib/assets/images/backdrop-default.png';
    String backdropPath = json['backdrop_path'] != null
        ? 'https://image.tmdb.org/t/p/w500${json['backdrop_path']}'
        : defaultBackdropPath;

    String dataJson = json['release_date'];
    DateTime data = DateTime.parse(dataJson);
    String dataNewFormat = DateFormat.yMMMMd('en_US').format(data);

    return MovieDetail(
      isAdult: json['adult'],
      backdropPath: backdropPath,
      originalTitle: json['original_title'],
      overview: json['overview'],
      title: json['title'],
      releaseDate: dataNewFormat,
      voteAverage: json['vote_average'].toDouble(),
      genres: List<Map<String, dynamic>>.from(json['genres']),
      key: videoKey,
    );
  }

  get adult => null;
}
