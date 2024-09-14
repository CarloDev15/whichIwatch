import 'package:collection/collection.dart';
import 'package:which_i_watch/model/movie.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'movies_state.freezed.dart';

@freezed
class MoviesState with _$MoviesState {
  const MoviesState._();

  const factory MoviesState({
    @Default([]) List<Movie> movies,
    @Default(false) bool isAscending,
  }) = _MoviesState;

  List<Movie> get sortedMovies => List<Movie>.from(movies)
    ..sort((a, b) => isAscending
        ? a.voteAverage.compareTo(b.voteAverage)
        : b.voteAverage.compareTo(a.voteAverage));

  Movie? movieById(String? movieId) =>
      movies.firstWhereOrNull((e) => e.id == movieId);
}
