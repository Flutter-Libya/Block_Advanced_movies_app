import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/movies/presentation/screens/movies_screen.dart';
import 'package:movies_app/presentation_main_app/screen/settings_screen.dart';
import 'package:movies_app/search/presentation/views/search_view.dart';
import 'package:movies_app/tvs/presentation/screens/tvs_screen.dart';

class MainState extends Equatable {
  MainState({this.currentIndex = 0});

  final int currentIndex;
  final List<Widget> screens = [
    const MoviesScreen(),
    const TvsScreen(),
    const SearchScreen(),
    const SettingsScreen(),
  ];

  @override
  List<Object> get props => [
        currentIndex,
        screens,
      ];
}
