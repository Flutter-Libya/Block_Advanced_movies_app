import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class Avatar extends StatelessWidget {
  const Avatar({
    super.key,
    required this.avatarUrl,
  });

  final String avatarUrl;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: avatarUrl,
      imageBuilder: (context, imageProvider) => CircleAvatar(
        radius: 20.r,
        backgroundColor: Colors.transparent,
        backgroundImage: imageProvider,
      ),
      placeholder: (context, _) => Shimmer.fromColors(
        baseColor: Colors.grey[850]!,
        highlightColor: Colors.grey[800]!,
        child: CircleAvatar(
          radius: 20.r,
        ),
      ),
      errorWidget: (_, __, ___) => Icon(
        Icons.error,
        color: Colors.red,
        size: 24.sp,
      ),
    );
  }
}
