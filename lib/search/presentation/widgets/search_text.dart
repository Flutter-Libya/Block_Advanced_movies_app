import 'package:flutter/material.dart';
import 'package:movies_app/core/global/theme/theme_data/theme_data.dart';
import 'package:movies_app/core/utils/enum.dart';

class SearchText extends StatelessWidget {
  const SearchText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = getThemeData[AppTheme.darkTheme]!.textTheme;

    return Expanded(
      child: Center(
        child: Text(
          'Search Text',
          style: textTheme.bodyLarge,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
