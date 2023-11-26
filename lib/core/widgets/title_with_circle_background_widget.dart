import 'package:easy_localization/easy_localization.dart' as tras;
import 'package:flutter/material.dart';
import 'package:new_mazoon/core/utils/getsize.dart';
import '../utils/app_colors.dart';

class TitleWithCircleBackgroundWidget extends StatefulWidget {
  TitleWithCircleBackgroundWidget({Key? key, required this.title, this.width})
      : super(key: key);
  double? width;
  final String title;

  @override
  State<TitleWithCircleBackgroundWidget> createState() =>
      _TitleWithCircleBackgroundWidgetState();
}

class _TitleWithCircleBackgroundWidgetState
    extends State<TitleWithCircleBackgroundWidget> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection:
          tras.EasyLocalization.of(context)!.currentLocale!.languageCode == 'ar'
              ? TextDirection.rtl
              : TextDirection.ltr,
      child: SizedBox(
        height: getSize(context) / 12,
        width: widget.width ?? MediaQuery.of(context).size.width / 2,
        child: Stack(
          children: [
            tras.EasyLocalization.of(context)!.currentLocale!.languageCode ==
                    'en'
                ? Positioned(
                    bottom: 0,
                    left: 15,
                    child: Container(
                      width: getSize(context) / 12,
                      height: getSize(context) / 12,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: AppColors.orangeThirdPrimary,
                      ),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 6.0),
                          child: Container(
                            width: getSize(context) / 12,
                            height: 1,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ),
                  )
                : Positioned(
                    bottom: 0,
                    right: tras.EasyLocalization.of(context)!
                                .currentLocale!
                                .languageCode ==
                            'ar'
                        ? 15
                        : 0,
                    child: Container(
                      width: getSize(context) / 12,
                      height: getSize(context) / 12,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: AppColors.orangeThirdPrimary,
                      ),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 6.0),
                          child: Container(
                            width: getSize(context) / 12,
                            height: 1,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ),
                  ),
            Positioned(
              bottom: 8,
              right: 0,
              left: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  // width: MediaQuery.of(context).size.width * 0.50,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.title.tr(),
                        style: TextStyle(
                          fontSize: getSize(context) / 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
