import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_mazoon/core/utils/app_colors.dart';
import 'package:new_mazoon/core/utils/assets_manager.dart';
import 'package:new_mazoon/core/utils/getsize.dart';
import 'package:new_mazoon/features/liveexam/cubit/cubit.dart';
import 'package:new_mazoon/features/liveexam/cubit/state.dart';

import '../../lessons_of_class/screens/view_video_screen.dart';
import '../../start_trip/widgets/class_exam_icon_widget.dart';

class LiveExamItemWidget extends StatelessWidget {
  LiveExamItemWidget({Key? key, required this.index}) : super(key: key);
  int index;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LiveExamCubit, LiveExamState>(
      builder: (context, state) {
        var cubit = context.read<LiveExamCubit>();
        return Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 20.0,
            horizontal: 15,
          ),
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: AppColors.liveExamBackgroundColor,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cubit.liveExams[index].name,
                        style: TextStyle(
                          color: AppColors.orangeThirdPrimary,
                          fontWeight: FontWeight.bold,
                          fontSize: getSize(context) / 22,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            ClassExamIconWidget(
                              radius: 1000,
                              type: ImageAssets.loveIcon,
                              iconLoveColor:
                                  cubit.liveExams[index].examsFavorite ==
                                          'un_favorite'
                                      ? AppColors.white
                                      : AppColors.red,
                              iconColor: Colors.indigoAccent,
                              onclick: () {
                                cubit.favourite(
                                    'life_exams',
                                    cubit.liveExams[index].examsFavorite ==
                                            'un_favorite'
                                        ? 'favorite'
                                        : 'un_favorite',
                                    index);
                              },
                            ),
                            cubit.liveExams[index].answerVideoFile == null
                                ? Container()
                                : Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: ClassExamIconWidget(
                                      radius: 1000,
                                      type: ImageAssets.videoIcon,
                                      iconLoveColor: AppColors.white,
                                      iconColor: Colors.blue,
                                      onclick: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AnswerVideoViewScreen(
                                                        isYoutube: 0,
                                                        videoLink: cubit
                                                            .liveExams[index]
                                                            .answerVideoFile!)));
                                      },
                                    ),
                                  ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Image.asset(
                  ImageAssets.liveExamImage,
                  height: 50,
                  width: 60,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
