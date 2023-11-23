import 'package:flutter/material.dart';
import 'package:new_mazoon/config/routes/app_routes.dart';
import 'package:new_mazoon/core/utils/getsize.dart';
import 'package:new_mazoon/core/utils/hex_color.dart';

import '../../../../core/models/home_page_model.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/widgets/my_svg_widget.dart';
import '../../../core/widgets/title_with_circle_background_widget.dart';
import '../../lessons_of_class/widgets/time.dart';

class HomePageVideoWidget extends StatelessWidget {
  const HomePageVideoWidget(
      {Key? key, required this.videosBasics, required this.title})
      : super(key: key);
  final List<HomePageVideosModel> videosBasics;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),
        TitleWithCircleBackgroundWidget(title: title),
        SizedBox(height: 20),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...List.generate(
                videosBasics.length,
                (index) => InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.videoDetailsScreenRoute,
                        arguments: {
                          'type': 'video_basic',
                          'videoId': videosBasics[index].id!,
                        });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Container(
                      height: getSize(context) / 3,
                      width: getSize(context) * 0.45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: HexColor(
                            videosBasics[index].backgroundColor ?? '#E4312A'),
                      ),
                      child: Column(
                        children: [
                          Flexible(
                            fit: FlexFit.tight,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: getSize(context) / 32,
                                  vertical: getSize(context) / 22),
                              child: Text(
                                videosBasics[index].name ?? '',
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: getSize(context) / 26,
                                  color: AppColors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(getSize(context) / 32),
                                child: MySvgWidget(
                                  path: ImageAssets.clockIcon,
                                  imageColor: AppColors.white,
                                  size: getSize(context) / 22,
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  myTime(videosBasics[index].time!),
                                  // 'hours'.tr(),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: getSize(context) / 32,
                                    color: AppColors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 40),
      ],
    );
  }
}
