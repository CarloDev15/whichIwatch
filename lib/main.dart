import 'package:which_i_watch/pages/movie_list_page.dart';
import 'package:which_i_watch/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import './bloc/movie_bloc.dart';
import './bloc/movie_detail_bloc.dart';
import 'pages/movie_detail_page.dart';

void main() {
  runApp(const SplashScreen());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => BlocProvider(
              create: (context) => MovieBloc()..getMovies(),
              child: const MovieListPage(),
            ),
            routes: [
              GoRoute(
                path: 'detail/:id',
                builder: (context, state) {
                  final movieId = state.pathParameters['id'];
                  if (movieId == null) {
                    return const Scaffold(
                      body: Center(
                        child: Text('MovieId non valido'),
                      ),
                    );
                  }
                  return BlocProvider(
                    create: (context) =>
                        MovieDetailBloc()..getMovieDetail(movieId),
                    child: MovieDetailPage(movieId: movieId),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
