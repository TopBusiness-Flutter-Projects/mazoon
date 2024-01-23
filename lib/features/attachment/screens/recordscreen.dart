import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_mazoon/core/utils/app_colors.dart';
import 'package:new_mazoon/core/utils/assets_manager.dart';
import 'package:new_mazoon/core/utils/dialogs.dart';
import 'package:new_mazoon/core/utils/getsize.dart';
import 'package:new_mazoon/core/utils/hex_color.dart';
import 'package:new_mazoon/core/widgets/my_svg_widget.dart';
import 'package:new_mazoon/features/audioview/screen/audioview.dart';
import '../cubit/attachmentcubit.dart';
import '../cubit/attachmentstate.dart';

class RecordScreenScreen extends StatefulWidget {
  const RecordScreenScreen({super.key});

  @override
  State<RecordScreenScreen> createState() => _RecordScreenScreenState();
}

class _RecordScreenScreenState extends State<RecordScreenScreen> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AttachmentCubit, AttachmentState>(
      listener: (context, state) {
        if (state is LoadingAudioAttchmentState) {
          isLoading = true;
        } else {
          isLoading = false;
        }
      },
      builder: (context, state) {
        var cubit = context.read<AttachmentCubit>();
        return isLoading
            ? Center(child: CircularProgressIndicator())
            : cubit.audioLessonData.isEmpty
                ? Center(
                    child: Text('no_data'.tr()),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(getSize(context) / 22),
                          width: double.infinity,
                          child: ListView.builder(
                            itemCount: cubit.audioLessonData.length,
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  if (cubit.audioLessonData[index].status ==
                                      'opened') {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AudioViewScreen(
                                                    index: index,
                                                    audioLessonData: cubit
                                                        .audioLessonData)));
                                  } else {
                                    errorGetBar('have_access'.tr());
                                  }
                                },
                                child: Container(
                                  padding:
                                      EdgeInsets.all(getSize(context) / 22),
                                  margin:
                                      EdgeInsets.all(getSize(context) / 100),
                                  decoration: BoxDecoration(
                                      color: HexColor(cubit
                                          .audioLessonData[index]
                                          .backgroundColor!),
                                      borderRadius: BorderRadius.circular(
                                          getSize(context) / 32)),
                                  width: double.infinity,
                                  child: Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            cubit.audioLessonData[index].name ??
                                                '',
                                            overflow: TextOverflow.clip,
                                            maxLines: 1,
                                            style: TextStyle(
                                                color: darken(
                                                    HexColor(
                                                      cubit
                                                          .audioLessonData[
                                                              index]
                                                          .backgroundColor!,
                                                    ),
                                                    .4),
                                                fontWeight: FontWeight.w700,
                                                fontSize:
                                                    getSize(context) / 22),
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              MySvgWidget(
                                                  ////Color from
                                                  path: ImageAssets.timeIcon,
                                                  imageColor: darken(
                                                      HexColor(
                                                        cubit
                                                            .audioLessonData[
                                                                index]
                                                            .backgroundColor!,
                                                      ),
                                                      .4),
                                                  size: getSize(context) / 22),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                        getSize(context) / 44),
                                                child: Text(
                                                  '${cubit.audioLessonData[index].size ?? 0} min',
                                                  style: TextStyle(
                                                    color: darken(
                                                        HexColor(
                                                          cubit
                                                              .audioLessonData[
                                                                  index]
                                                              .backgroundColor!,
                                                        ),
                                                        .4),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      Spacer(),
                                      CircleAvatar(
                                        //color from back
                                        backgroundColor: darken(
                                            HexColor(
                                              cubit.audioLessonData[index]
                                                  .backgroundColor!,
                                            ),
                                            .4),
                                        child: MySvgWidget(
                                            //check if 100% done of lock
                                            path: cubit.audioLessonData[index]
                                                        .status ==
                                                    "lock"
                                                ? ImageAssets.lockIcon
                                                : ImageAssets.doneIcon,
                                            imageColor: AppColors.white,
                                            size: getSize(context) / 22),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  );
      },
    );
  }
}
