import 'package:which_i_watch/model/movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../bloc/movie_bloc.dart';

class MovieListPage extends StatelessWidget {
  const MovieListPage({super.key});

  get scrollController => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(13, 37, 63, 1),
      appBar: AppBar(
        title: Image.asset('lib/assets/images/logo-wiw-transparent.png',
            width: 130),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(13, 37, 63, 1),
        actions: [
          IconButton(
            onPressed: () => context.read<MovieBloc>().sortMovies(),
            icon: BlocBuilder<MovieBloc, List<Movie>>(
              builder: (context, movies) {
                final isAscending = context.read<MovieBloc>().isAscending;
                return isAscending
                    ? Transform.rotate(
                        angle: 3.14,
                        child:
                            const Icon(Icons.sort_rounded, color: Colors.white),
                      )
                    : const Icon(Icons.sort_rounded, color: Colors.white);
              },
            ),
          ),
        ],
      ),
      body: BlocBuilder<MovieBloc, List<Movie>>(
        builder: (context, movies) {
          return ListView.builder(
            controller: scrollController,
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];
              double rating = movie.voteAverage / 2;
              rating = (rating * 2).round() / 2;

              List<Widget> stars = [];
              for (int i = 0; i < 5; i++) {
                if (rating >= 1) {
                  stars.add(const Icon(Icons.star, color: Colors.yellow));
                  rating--;
                } else if (rating >= 0.5) {
                  stars.add(const Icon(Icons.star_half, color: Colors.yellow));
                  rating -= 0.5;
                } else {
                  stars.add(const Icon(Icons.star_border,
                      color: Color.fromARGB(255, 255, 230, 0)));
                }
              }

              return GestureDetector(
                onTap: () {
                  context.go('/detail/${movie.id}');
                },
                child: Card(
                  elevation: 0.2,
                  color: const Color.fromARGB(43, 1, 49, 66),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Container(
                    height: 150,
                    margin: const EdgeInsets.all(8.0),
                    padding: const EdgeInsets.all(2.0),
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: 130,
                          child: movie.posterPath.contains('http')
                              ? Image.network(movie.posterPath,
                                  fit: BoxFit.contain)
                              : Image(
                                  image: AssetImage(movie.posterPath),
                                  fit: BoxFit.contain),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: Text(movie.title,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontFamily: 'Manrope-ExtraBold')),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 2.0),
                                child: Text(
                                    'Data release: ${movie.releaseDate}',
                                    style: TextStyle(
                                        color: Colors.grey[400],
                                        fontSize: 12,
                                        fontStyle: FontStyle.italic)),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: stars,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.small(
            backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
            foregroundColor: const Color.fromRGBO(13, 37, 63, 1),
            splashColor: const Color.fromRGBO(1, 180, 228, 1),
            onPressed: () {
              context.read<MovieBloc>().previousPage();
            },
            child: const Icon(Icons.navigate_before),
          ),
          const SizedBox(width: 10),
          FloatingActionButton.small(
            backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
            foregroundColor: const Color.fromRGBO(13, 37, 63, 1),
            splashColor: const Color.fromRGBO(1, 180, 228, 1),
            onPressed: () {
              context.read<MovieBloc>().nextPage();
            },
            child: const Icon(Icons.navigate_next),
          ),
        ],
      ),
    );
  }
}
