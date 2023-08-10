import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app/core/components/size_box.dart';
import 'package:movies_app/core/global/app_string/app_string.dart';
import 'package:movies_app/core/global/theme/app_color/app_color_dark.dart';
import 'package:movies_app/core/global/theme/theme_data/theme_data.dart';
import 'package:movies_app/core/utils/enum.dart';
import 'package:movies_app/core/utils/function.dart';
import 'package:movies_app/generated/assets.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = getThemeData[AppTheme.darkTheme]!.textTheme;

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0).r,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 20, bottom: 20).r,
              child: CircleAvatar(
                maxRadius: 93.r,
                minRadius: 93.r,
                backgroundColor: AppColorsDark.primaryGreenColor,
                child: CircleAvatar(
                  maxRadius: 90.r,
                  minRadius: 90.r,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(95).r,
                    child: Image.asset(
                      Assets.imagesLogo,
                      fit: BoxFit.fill,
                      width: double.infinity,
                      height: 200.h,
                    ),
                  ),
                ),
              ),
            ),
            Text(
              AppString.help,
              style: textTheme.titleLarge,
            ),
            Space(height: 10.h, width: 0),
            cardItem(
                title: 'Chat Me',
                url: 'badirajari@gmail.com',
                imageSvg: Assets.imagesGoogle),
            Space(height: 10.h, width: 0),
            cardItem(
              title: 'GitHub',
              url: 'https://github.com/Flutter-Libya',
              imageSvg: Assets.imagesGithub,
            ),
            Space(height: 10.h, width: 0),
            cardItem(
              title: 'LinkedIn',
              url: 'https://github.com/Flutter-Libya',
              imageSvg: Assets.imagesLinkedin,
            ),
            Space(height: 10.h, width: 0),
            cardItem(
              title: 'Portfolio',
              url: 'https://github.com/Flutter-Libya',
              imageSvg: Assets.imagesEarth,
            ),
          ],
        ),
      ),
    );
  }

  Widget cardItem({
    required String title,
    required String url,
    required String imageSvg,
  }) {
    final textTheme = getThemeData[AppTheme.darkTheme]!.textTheme;

    return Card(
      color: AppColorsDark.greyDarkColor,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15).r),
      elevation: 10,
      child: InkWell(
        onTap: () {
          urlLauncher(
            Uri.parse(url),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(10).r,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 22.r,
                backgroundColor: Colors.transparent,
                child: SvgPicture.asset(
                  imageSvg,
                  colorFilter: const ColorFilter.mode(
                    AppColorsDark.primaryGreenColor,
                    BlendMode.srcATop,
                  ),
                ),
              ),
              Space(
                width: 35.w,
                height: 0.h,
              ),
              Text(
                title,
                style: textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
