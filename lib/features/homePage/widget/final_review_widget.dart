import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/routes/app_routes.dart';
import '../../../core/models/home_page_model.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/assets_manager.dart';
import '../../../core/utils/hex_color.dart';
import '../../../core/widgets/download_icon_widget.dart';
import '../../../core/widgets/my_svg_widget.dart';
import '../../../core/widgets/pdf_screen.dart';
import '../../../core/widgets/title_with_circle_background_widget.dart';
import '../../video_details/cubit/video_details_cubit.dart';

class FinalReviewWidget extends StatelessWidget {
  const FinalReviewWidget({Key? key, required this.model, required this.title})
      : super(key: key);
  final List<FinalReviewModel> model;
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
                model.length,
                (index) => InkWell(
                  onTap: () {
                    model[index].type == 'video'
                        ? {
                            context.read<VideoDetailsCubit>().getVideoDetails(
                                model[index].id!, "video_resource"),
                            context.read<VideoDetailsCubit>().getcomments(
                                model[index].id!, "video_resource"),
                            Navigator.pushNamed(
                                context, Routes.videoDetailsScreenRoute,
                                arguments: {
                                  'type': 'video_resource',
                                  'videoId': model[index].id!,
                                })
                          }
                        : Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PdfScreen(
                                pdfTitle: model[index].name!,
                                pdfLink: model[index].pathFile!,
                              ),
                            ),
                          );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Container(
                      height: 120,
                      width: MediaQuery.of(context).size.width * 0.45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: HexColor(
                          model[index].backgroundColor ?? '#E4312A',
                        ),
                      ),
                      child: Column(
                        children: [
                          Spacer(),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              children: [
                                SizedBox(width: 8),
                                MySvgWidget(
                                    path: model[index].type == 'video'
                                        ? ImageAssets.videoIcon
                                        : ImageAssets.pdfIcon,
                                    imageColor: AppColors.white,
                                    size: 20),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    model[index].name!,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: AppColors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
                          Row(
                            children: [
                              SizedBox(width: 16),
                              model[index].type == 'video'
                                  ? MySvgWidget(
                                      path: ImageAssets.clockIcon,
                                      imageColor: AppColors.white,
                                      size: 16,
                                    )
                                  : DownloadIconWidget(
                                      color: HexColor(
                                        model[index].backgroundColor!,
                                      ),
                                    ),
                              SizedBox(width: 10),
                              Text(
                                model[index].type == 'video'
                                    ? '${model[index].time!} ساعه '
                                    : ' 2 MB',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Spacer(),
                            ],
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                  ),
                ),
              ).reversed,
            ],
          ),
        ),
        SizedBox(height: 40),
      ],
    );
  }
}
