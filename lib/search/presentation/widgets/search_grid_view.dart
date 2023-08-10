import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/search/domain/entities/search_result_item.dart';
import 'package:movies_app/search/presentation/widgets/grid_view_card.dart';

class SearchGridView extends StatelessWidget {
  const SearchGridView({
    super.key,
    required this.results,
  });

  final List<SearchResultItem> results;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        padding: const EdgeInsets.symmetric(vertical: 12).r,
        itemCount: results.length,
        physics: const BouncingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 12,
          childAspectRatio: 0.55,
        ),
        itemBuilder: (context, index) {
          return GridViewCard(item: results[index]);
        },
      ),
    );
  }
}
