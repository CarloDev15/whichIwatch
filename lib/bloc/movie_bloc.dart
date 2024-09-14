import 'package:which_i_watch/api_key.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/movie.dart';

class MovieBloc extends Cubit<List<Movie>> {
  MovieBloc() : super([]);

  bool isAscending = true;

  int currentPage = 1; // Aggiunto il numero della pagina corrente
  int totalPages = 1; // Aggiunto il numero totale di pagine disponibili

  Future<void> getMovies() async {
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/now_playing?api_key=$apiKey&language=it-IT&region=IT&page=$currentPage'));
    final Map<String, dynamic> decodedJson = json.decode(response.body);
    final List<dynamic> moviesJson = decodedJson['results'];
    totalPages =
        decodedJson['total_pages']; // Aggiornato il numero totale di pagine
    final movies = moviesJson.map((json) => Movie.fromJson(json)).toList();
    emit(movies);
  }

  void sortMovies() {
    final movies = state;
    movies.sort((a, b) => isAscending
        ? a.voteAverage.compareTo(b.voteAverage)
        : b.voteAverage.compareTo(a.voteAverage));
    isAscending = !isAscending;
    emit(List.from(movies));
  }

  // Metodo per avanzare alla pagina successiva
  void nextPage() {
    if (currentPage < totalPages) {
      currentPage++;
      getMovies(); // Richiama la funzione per ottenere i film della nuova pagina
    }
  }

  // Metodo per tornare alla pagina precedente
  void previousPage() {
    if (currentPage > 1) {
      currentPage--;
      getMovies(); // Richiama la funzione per ottenere i film della nuova pagina
    }
  }
}
