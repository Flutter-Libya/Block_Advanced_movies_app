import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/services/services_locator.dart';
import 'package:movies_app/movies/presentation/controller/movies_bloc.dart';
import 'package:movies_app/movies/presentation/controller/movies_events.dart';
import 'package:movies_app/presentation_main_app/controller/main_bloc.dart';
import 'package:movies_app/presentation_main_app/screen/main_screen.dart';
import 'package:movies_app/tvs/presentation/controller/tvs_bloc.dart';
import 'package:movies_app/tvs/presentation/controller/tvs_events.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<MainBloc>()),
        BlocProvider(
          create: (context) => sl<MoviesBloc>()
            ..add(GetNowPlayingMoviesEvent())
            ..add(GetPopularMoviesEvent())
            ..add(GetTopRatedMoviesEvent()),
        ),
        BlocProvider(
            create: (context) => sl<TvsBloc>()
              ..add(GetOnTheAirTvsEvent())
              ..add(GetAiringTodayTvsEvent())),
      ],
      child: const MainScreen(),
    );
  }
}
