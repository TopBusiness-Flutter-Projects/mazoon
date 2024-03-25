import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_mazoon/config/routes/app_routes.dart';
import 'package:new_mazoon/core/utils/getsize.dart';
import 'package:new_mazoon/core/utils/hex_color.dart';
import 'package:new_mazoon/core/widgets/network_image.dart';
import 'package:new_mazoon/core/widgets/no_data_widget.dart';
import 'package:new_mazoon/core/widgets/show_loading_indicator.dart';
import 'package:new_mazoon/features/lessons_of_class/cubit/lessons_class_cubit.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/toast_message_method.dart';
import '../../../core/widgets/my_painter_widget.dart';
import '../../homePage/cubit/home_page_cubit.dart';
import '../../homePage/widget/home_page_app_bar_widget.dart';
import '../cubit/lessons_class_state.dart';
import '../widgets/lesson_class_item_widget.dart';

class LessonsClassScreen extends StatefulWidget {
  const LessonsClassScreen({Key? key, required this.classId}) : super(key: key);
  final int classId;

  @override
  State<LessonsClassScreen> createState() => _LessonsClassScreenState();
}

class _LessonsClassScreenState extends State<LessonsClassScreen> {
  @override
  void initState() {
    super.initState();
    context
        .read<LessonsClassCubit>()
        .getLessonsClassData(widget.classId, 1, context, false, false, false);
    context.read<HomePageCubit>().openFirstClass(widget.classId);
  }

  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LessonsClassCubit, LessonsClassState>(
      listener: (context, state) {
        if (state is LessonsClassLoading) {
          isLoading = true;
        } else {
          isLoading = false;
        }
      },
      builder: (context, state) {
        LessonsClassCubit cubit = context.read<LessonsClassCubit>();
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.secondPrimary,
            toolbarHeight: 0,
          ),
          body: SafeArea(
            child: isLoading
                ? ShowLoadingIndicator()
                : Stack(
                    children: [
                      RefreshIndicator(
                        onRefresh: () async {
                          cubit.getLessonsClassData(
                              widget.classId, 1, context, false, false, false);
                        },
                        child: ListView(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          children: [
                            SizedBox(height: getSize(context) / 3),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: getSize(context) / 22),
                              child: SizedBox(
                                height: getSize(context) / 2,
                                width: getSize(context) - 80,
                                child: Card(
                                  elevation: 20,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        getSize(context) / 32),
                                  ),
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        top: 0,
                                        left: 0,
                                        right:
                                            MediaQuery.of(context).size.width *
                                                0.25,
                                        bottom: 0,
                                        child: ClipPath(
                                          clipper: CCustomClipper(),
                                          child: ManageNetworkImage(
                                            imageUrl: cubit.oneClass?.image ??
                                                "https://elmazone.topbusiness.io/sliders/1.jpg",
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        right: 0,
                                        child: CustomPaint(
                                          size: Size(
                                            getSize(context) / 2,
                                            getSize(context) / 2,
                                          ),
                                          painter: MyPainter(
                                            darken(
                                                HexColor(
                                                  cubit.oneClass!
                                                      .backgroundColor!,
                                                ),
                                                0.2),
                                          ),
                                        ),
                                      ),
                                      Stack(
                                        children: [
                                          CustomPaint(
                                            size: Size(
                                              getSize(context) / 2,
                                              getSize(context) / 3,
                                            ),
                                            painter: MyPainter(
                                              HexColor(
                                                cubit
                                                    .oneClass!.backgroundColor!,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Positioned(
                                        right: getSize(context) / 32,
                                        top: getSize(context) / 15,
                                        child: Container(
                                          width: getSize(context) / 3,
                                          child: Text(
                                            cubit.oneClass!.title!,
                                            maxLines: 3,
                                            overflow: TextOverflow.fade,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: getSize(context) / 18,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: getSize(context) / 2.8,
                                        right: getSize(context) / 32,
                                        child: Container(
                                          width: getSize(context) / 3,
                                          child: Text(
                                            cubit.oneClass!.name!,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: AppColors.white,
                                              fontSize: getSize(context) / 22,
                                              fontWeight: FontWeight.bold,
                                              shadows: <Shadow>[
                                                Shadow(
                                                  offset: Offset(3.0, 3.0),
                                                  blurRadius: 3.0,
                                                  color: Color.fromARGB(
                                                      255, 0, 0, 0),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: getSize(context) / 32),
                            ...List.generate(
                              cubit.lessons.length,
                              (index) => InkWell(
                                onTap: () {
                                  if (cubit.lessons[index].status == 'lock') {
                                    toastMessage(
                                      'open_lesson'.tr(),
                                      context,
                                      color: AppColors.error,
                                    );
                                  } else {
                                    Navigator.pushNamed(
                                        context, Routes.lessonDetails,
                                        arguments: cubit.lessons[index]);
                                  }
                                },
                                child: LessonClassItemWidget(
                                  model: cubit.lessons[index],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        left: 0,
                        child: HomePageAppBarWidget(isHome: false),
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }
}

class CCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    Path path_0 = Path();
    path_0.moveTo(0, size.height * 0.06578947);
    path_0.cubicTo(0, size.height * 0.02945493, size.width * 0.01139224, 0,
        size.width * 0.02544529, 0);
    path_0.lineTo(size.width * 0.65, 0);
    path_0.lineTo(size.width * 0.99, size.height);
    path_0.lineTo(size.width * 0.02544529, size.height);
    path_0.cubicTo(size.width * 0.01139224, size.height, 0,
        size.height * 0.9705461, 0, size.height * 0.9342105);
    path_0.lineTo(0, size.height * 0.06578947);
    path_0.close();

    return path_0;

    // final double heightDelta = size.height / 2.2;

    // Path()
    //  ..addRect(
    //      Rect.fromLTWH(35, 120, 260, 160))
    //  ;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
