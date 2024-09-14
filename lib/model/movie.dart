import 'package:intl/intl.dart';

class Movie {
  final String posterPath;
  final String title;
  final String releaseDate;
  final double voteAverage;
  final String id;

  Movie({
    required this.posterPath,
    required this.title,
    required this.releaseDate,
    required this.voteAverage,
    required this.id,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    String defaultImagePath = 'lib/assets/images/poster-default.png';
    String posterPath = json['poster_path'] != null
        ? 'https://image.tmdb.org/t/p/w500${json['poster_path']}'
        : defaultImagePath;

    String dataJson = json['release_date'];
    DateTime data = DateTime.parse(dataJson);
    String dataNewFormat = DateFormat.yMMMMd('en_US').format(data);

    return Movie(
      posterPath: posterPath,
      title: json['title'],
      releaseDate: dataNewFormat,
      voteAverage: json['vote_average'].toDouble(),
      id: json['id'].toString(),
    );
  }
}
