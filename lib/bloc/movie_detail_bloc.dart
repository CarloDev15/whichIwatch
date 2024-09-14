import 'package:which_i_watch/api_key.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/movie_detail.dart';

class MovieDetailBloc extends Cubit<MovieDetail?> {
  MovieDetailBloc() : super(null);

  Future<void> getMovieDetail(String movieId) async {
    final response = await http.get(Uri.parse(
        'http://api.themoviedb.org/3/movie/$movieId?api_key=$apiKey&append_to_response=videos&language=it-IT'));
    final movieDetailJson = json.decode(response.body);
    final movieDetail = MovieDetail.fromJson(movieDetailJson);
    emit(movieDetail);
  }
}
