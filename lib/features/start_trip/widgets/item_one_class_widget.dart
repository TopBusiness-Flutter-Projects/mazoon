import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../config/routes/app_routes.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/assets_manager.dart';
import '../../../core/widgets/my_svg_widget.dart';
import '../../../core/widgets/network_image.dart';
import '../../lessons_of_class/screens/lesson_class.dart';

class ItemOfOneClassWidget extends StatelessWidget {
  const ItemOfOneClassWidget({
    Key? key,
    required this.classNum,
    required this.classTitle,
    required this.classPresentFinished,
    required this.lessonNum,
    required this.videoNum,
    required this.hourNum,
    required this.imagePath,
    required this.status,
    required this.mainColor,
    required this.classId,
  }) : super(key: key);

  final String classNum;
  final String classTitle;
  final String classPresentFinished;
  final String lessonNum;
  final String videoNum;
  final String hourNum;
  final String imagePath;
  final String status;
  final Color mainColor;
  final int classId;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 15,
          left: 15,
          right: 0,
          bottom: 0,
          child: Container(
            width: 80,
            height: 207,
            decoration: BoxDecoration(
              color: mainColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    classNum,
                    style: TextStyle(color: AppColors.white, fontSize: 15),
                  ),
                ),
                SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    classTitle,
                    style: TextStyle(color: AppColors.white, fontSize: 13),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: SizedBox(
                        width: 90,
                        height: 90,
                        child: SfCircularChart(
                          palette: [darken(mainColor, 0.08)],
                          annotations: <CircularChartAnnotation>[
                            CircularChartAnnotation(
                              widget: status == 'lock'
                                  ? MySvgWidget(
                                      size: 18,
                                      imageColor: AppColors.white,
                                      path: ImageAssets.lockIcon,
                                    )
                                  : Text(
                                      classPresentFinished,
                                      style: TextStyle(
                                        color: AppColors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            ),
                          ],
                          series: <CircularSeries>[
                            RadialBarSeries<int, String>(
                              maximumValue: 100,
                              innerRadius: '20',
                              dataSource: [int.parse(classPresentFinished)],
                              cornerStyle: CornerStyle.endCurve,
                              xValueMapper: (int data, _) => data.toString(),
                              yValueMapper: (int data, _) =>
                                  double.parse(data.toString()),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Row(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 0,
                                horizontal: 5,
                              ),
                              width: 2,
                              height: 80,
                              color: AppColors.white,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Icon(
                                        Icons.sticky_note_2_outlined,
                                        color: AppColors.white,
                                        size: 16,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0,
                                        ),
                                        child: Text(
                                          lessonNum,
                                          style: TextStyle(
                                            color: AppColors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Text(
                                        'دروس',
                                        style: TextStyle(
                                          color: AppColors.white,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Icon(
                                        Icons.slow_motion_video,
                                        color: AppColors.white,
                                        size: 16,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0,
                                        ),
                                        child: Text(
                                          videoNum,
                                          style: TextStyle(
                                            color: AppColors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Text(
                                        'فيديو',
                                        style: TextStyle(
                                          color: AppColors.white,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Icon(
                                        Icons.access_time_outlined,
                                        color: AppColors.white,
                                        size: 16,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0,
                                        ),
                                        child: Text(
                                          hourNum,
                                          style: TextStyle(
                                            color: AppColors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Text(
                                        'ساعه',
                                        style: TextStyle(
                                          color: AppColors.white,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      height: 2,
                      width: MediaQuery.of(context).size.width / 3 + 20,
                      color: AppColors.white,
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: status == 'lock'
                            ? MainAxisAlignment.center
                            : MainAxisAlignment.end,
                        children: [
                          if (status == 'lock') ...{
                            Text(
                              'لم يتم فتخ هذا الفصل بعد',
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          } else ...{
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                 Routes.lessonClassScreenRoute,
                                   arguments: classId,
                                  );
                                },
                                child: Container(
                                  width: 107,
                                  height: 35,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: AppColors.white, width: 2),
                                    borderRadius: BorderRadius.circular(50),
                                    color: darken(mainColor, 0.1),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'ابدأ ذاكر',
                                      style: TextStyle(
                                        color: AppColors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          }
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          child: ManageNetworkImage(
            imageUrl: imagePath,
            height: 50,
            width: 50,
          ),
        )
      ],
    );
  }
}
