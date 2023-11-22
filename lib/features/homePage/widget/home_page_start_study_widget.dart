import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:new_mazoon/features/lessons_of_class/screens/lesson_class.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/toast_message_method.dart';
import '../../../../core/widgets/container_with_two_color_widget.dart';
import '../../../core/models/class_data.dart';
import '../../../core/widgets/title_with_circle_background_widget.dart';

class HomePageStartStudyWidget extends StatelessWidget {
  const HomePageStartStudyWidget({Key? key, required this.classes})
      : super(key: key);
  final List<AllClasses> classes;

  @override
  Widget build(BuildContext context) {
    print('classes.length');
    print(classes.length);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleWithCircleBackgroundWidget(title: 'start_study'),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              // childAspectRatio: .9,
              mainAxisSpacing: 30,
              crossAxisSpacing: 0,
              crossAxisCount: 3,
            ),
            itemCount: classes.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  if (classes[index].status == 'lock') {
                    toastMessage(
                      'open_class'.tr(),
                      context,
                      color: AppColors.error,
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LessonsClassScreen(
                          classId: classes[index].id!,
                        ),
                      ),
                    );
                  }
                },
                child: ContainerWithTwoColorWidget(
                  title: classes[index].name!,
                  imagePath: classes[index].image!,
                  color1: AppColors.blueColor1,
                  color2: AppColors.blueColor2,
                  textColor: AppColors.secondPrimary,
                  isHome: true,
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
