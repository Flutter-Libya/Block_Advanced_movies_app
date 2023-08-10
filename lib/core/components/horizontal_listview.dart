import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/components/size_box.dart';

class HorizontalListView extends StatefulWidget {
  final int itemCount;
  final Widget Function(BuildContext context, int index) itemBuilder;
  final Function addEvent;

  const HorizontalListView({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    required this.addEvent,
  });

  @override
  State<HorizontalListView> createState() => _HorizontalListViewState();
}

class _HorizontalListViewState extends State<HorizontalListView> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130.h,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        itemCount: widget.itemCount,
        itemBuilder: widget.itemBuilder,
        separatorBuilder: (context, index) {
          return Space(
            height: 10.sp,
            width: 0,
          );
        },
      ),
    );
  }

  void _onScroll() {
    if (_scrollController.position.atEdge) {
      if (_scrollController.position.pixels != 0) {
        widget.addEvent();
      }
    }
  }
}
