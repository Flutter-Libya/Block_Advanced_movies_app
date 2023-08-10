import 'package:flutter/material.dart';
import 'package:movies_app/core/network/api_constance.dart';
import 'package:url_launcher/url_launcher.dart';

String getProfileImageUrl(Map<String, dynamic> json) {
  if (json['profile_path'] != null) {
    return ApiConstance.baseProfileUrl + json['profile_path'];
  } else {
    return ApiConstance.castPlaceHolder;
  }
}

String getAvatarUrl(String? path) {
  if (path != null) {
    if (path.startsWith('/https://www.gravatar.com/avatar')) {
      return path.substring(1);
    } else {
      return ApiConstance.baseAvatarUrl + path;
    }
  } else {
    return ApiConstance.avatarPlaceHolder;
  }
}

String getElapsedTime(String date) {
  DateTime reviewDate = DateTime.parse(date);
  DateTime today = DateTime.now();

  Duration diff = today.difference(reviewDate);
  if (diff.inDays >= 365) {
    int years = diff.inDays ~/ 365;
    return '${years}y';
  } else if (diff.inDays >= 30) {
    int months = diff.inDays ~/ 30;
    return '${months}mo';
  } else if (diff.inDays >= 7) {
    int weeks = diff.inDays ~/ 7;
    return '${weeks}w';
  } else if (diff.inDays >= 1) {
    return '${diff.inDays}d';
  } else if (diff.inHours >= 1) {
    int hours = diff.inHours ~/ 24;
    return '${hours}h';
  } else if (diff.inMinutes >= 1) {
    int minutes = diff.inDays ~/ 60;
    return '${minutes}min';
  } else {
    return 'Now';
  }
}

void showCustomBottomSheet(BuildContext context, Widget child) {
  final size = MediaQuery.of(context).size.height;
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(20),
      ),
    ),
    builder: (context) {
      return SizedBox(
        height: size * 0.5,
        child: child,
      );
    },
  );
}

String getTrailerUrl(Map<String, dynamic> json) {
  List videos = json['videos']['results'];
  if (videos.isNotEmpty) {
    List trailers = videos.where((e) => e['type'] == 'Trailer').toList();
    if (trailers.isNotEmpty) {
      return ApiConstance.baseVideoUrl + trailers.last['key'];
    } else {
      return '';
    }
  } else {
    return '';
  }
}

String getDate(String? date) {
  if (date == null || date.isEmpty) {
    return '';
  }

  final values = date.split('-');
  String year = values[0];
  int monthNum = int.parse(values[1]);
  String day = values[2];

  String month = '';

  switch (monthNum) {
    case 1:
      month = 'Jan';
      break;
    case 2:
      month = 'Feb';
      break;
    case 3:
      month = 'Mar';
      break;
    case 4:
      month = 'Apr';
      break;
    case 5:
      month = 'May';
      break;
    case 6:
      month = 'Jun';
      break;
    case 7:
      month = 'Jul';
      break;
    case 8:
      month = 'Aug';
      break;
    case 9:
      month = 'Sep';
      break;
    case 10:
      month = 'Oct';
      break;
    case 11:
      month = 'Nov';
      break;
    case 12:
      month = 'Dec';
      break;
    default:
      break;
  }

  return '$month $day, $year';
}

Future<void> urlLauncher(Uri url) async {
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}
