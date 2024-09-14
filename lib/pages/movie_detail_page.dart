import 'package:which_i_watch/model/movie_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import '../bloc/movie_detail_bloc.dart';

class MovieDetailPage extends StatelessWidget {
  final String movieId;

  const MovieDetailPage({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(13, 37, 63, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(13, 37, 63, 1),
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text('Movie details',
            style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontFamily: 'Manrope-ExtraBold')),
      ),
      body: BlocBuilder<MovieDetailBloc, MovieDetail?>(
        builder: (context, movieDetail) {
          if (movieDetail == null) {
            return Container(
              color: const Color.fromRGBO(13, 37, 63, 1),
              child: const Center(
                  child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Color.fromRGBO(1, 180, 228, 1),
                ),
              )),
            );
          } else {
            return ListView(
              children: [
                Stack(
                  children: [
                    SizedBox(
                      child: movieDetail.backdropPath.contains('http')
                          ? Image.network(movieDetail.backdropPath)
                          : Image(image: AssetImage(movieDetail.backdropPath)),
                    ),
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.center,
                        child: Visibility(
                          visible: movieDetail.key != '',
                          child: IconButton(
                            icon: const Icon(Icons.play_circle_fill,
                                size: 60,
                                color: Color.fromRGBO(1, 180, 228, 1)),
                            onPressed: (movieDetail.key != '')
                                ? () async {
                                    final String videoKey = movieDetail.key;
                                    await launchUrl(Uri.parse(
                                        'https://www.youtube.com/watch?v=$videoKey'));
                                  }
                                : null,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Card(
                  margin: const EdgeInsets.all(8.0),
                  color: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(movieDetail.title,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Color.fromRGBO(1, 180, 228, 1),
                                fontSize: 26,
                                fontFamily: 'Manrope-ExtraBold')),
                        const SizedBox(height: 8.0),
                        Text(movieDetail.originalTitle,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: 'Manrope-ExtraBold')),
                        const Divider(),
                        Text(
                            movieDetail.overview.isEmpty ||
                                    movieDetail.overview ==
                                        movieDetail.originalTitle
                                ? 'Overview not ready'
                                : movieDetail.overview,
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Manrope-Medium')),
                        const Divider(),
                        const Text('Data release',
                            style: TextStyle(
                                color: Color.fromRGBO(1, 180, 228, 1),
                                fontSize: 15,
                                fontFamily: 'Manrope-ExtraBold')),
                        Text(movieDetail.releaseDate,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: 'Manrope-Medium')),
                        const Divider(),
                        const Text('Average rating',
                            style: TextStyle(
                                color: Color.fromRGBO(1, 180, 228, 1),
                                fontSize: 15,
                                fontFamily: 'Manrope-ExtraBold')),
                        Text(
                            movieDetail.voteAverage
                                .toStringAsFixed(1)
                                .toString(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: 'Manrope-Medium')),
                        const Divider(),
                        const Text('Genre',
                            style: TextStyle(
                                color: Color.fromRGBO(1, 180, 228, 1),
                                fontSize: 15,
                                fontFamily: 'Manrope-ExtraBold')),
                        Text(
                            movieDetail.genres.isEmpty
                                ? 'No genre available'
                                : movieDetail.genres
                                    .map((genre) => genre['name'])
                                    .join(", "),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: 'Manrope-Medium')),
                        const Divider(),
                        const Text('Classification',
                            style: TextStyle(
                                color: Color.fromRGBO(1, 180, 228, 1),
                                fontSize: 15,
                                fontFamily: 'Manrope-ExtraBold')),
                        Text(movieDetail.isAdult ? 'Only adults' : 'For all',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: 'Manrope-Medium')),
                        const Divider(),
                        Image.asset(
                          'lib/assets/images/logo-wiw-transparent.png',
                          width: 120,
                          height: 120,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
