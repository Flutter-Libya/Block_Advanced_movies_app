import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/components/loading_indicator.dart';
import 'package:movies_app/core/global/theme/theme_data/theme_data.dart';
import 'package:movies_app/core/services/services_locator.dart';
import 'package:movies_app/core/utils/enum.dart';
import 'package:movies_app/search/presentation/controllers/search_bloc/search_bloc.dart';
import 'package:movies_app/search/presentation/controllers/search_bloc/search_state.dart';
import 'package:movies_app/search/presentation/widgets/no_results.dart';
import 'package:movies_app/search/presentation/widgets/search_bar.dart';
import 'package:movies_app/search/presentation/widgets/search_grid_view.dart';
import 'package:movies_app/search/presentation/widgets/search_text.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SearchBloc>(),
      child: const SearchWidget(),
    );
  }
}

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = getThemeData[AppTheme.darkTheme]!.textTheme;

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(
            top: 12,
            left: 16,
            right: 16,
          ).r,
          child: Column(
            children: [
              const SearchBarItem(),
              BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  switch (state.status) {
                    case SearchRequestStatus.empty:
                      return const SearchText();
                    case SearchRequestStatus.loading:
                      return const Expanded(child: LoadingIndicator());
                    case SearchRequestStatus.loaded:
                      return SearchGridView(results: state.searchResults);
                    case SearchRequestStatus.error:
                      return Expanded(
                        child: Text(
                          'Please try again later',
                          style: textTheme.titleMedium,
                        ),
                      );
                    case SearchRequestStatus.noResults:
                      return const NoResults();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
