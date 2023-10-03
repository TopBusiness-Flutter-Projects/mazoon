import 'dart:io';

import 'package:easy_localization/easy_localization.dart' as trans;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_mazoon/core/utils/getsize.dart';
import 'package:new_mazoon/core/widgets/custom_button.dart';
import 'package:new_mazoon/core/widgets/my_svg_widget.dart';
import 'package:new_mazoon/features/video_details/cubit/video_details_cubit.dart';
import 'package:new_mazoon/features/video_details/widget/comments.dart';
import '../../../config/routes/app_routes.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/assets_manager.dart';
import '../../../core/widgets/custom_textfield.dart';
import '../../../core/widgets/music_animation.dart';
import '../../../core/widgets/no_data_widget.dart';
import '../../../core/widgets/show_loading_indicator.dart';
import '../../../core/widgets/video_widget.dart';
import '../../homePage/cubit/home_page_cubit.dart';
import '../widget/choose_icon_dialog.dart';
import '../widget/report.dart';
import 'package:get/get.dart' as git;

class VideoDetails extends StatefulWidget {
  VideoDetails({this.type, this.videoId, Key? key}) : super(key: key);
  final int? videoId;
  final String? type;
  @override
  State<VideoDetails> createState() => _VideoDetailsState();
}

class _VideoDetailsState extends State<VideoDetails> {
  @override
  void initState() {
    context.read<VideoDetailsCubit>().getDirectionPath();
    context.read<VideoDetailsCubit>().videoModel = null;
    context
        .read<VideoDetailsCubit>()
        .getVideoDetails(widget.videoId!, widget.type!);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ///////////

    /////////

    return BlocBuilder<HomePageCubit, HomePageState>(
      builder: (context, state) {
        var controller = context.read<HomePageCubit>();
        return BlocBuilder<VideoDetailsCubit, VideoDetailsState>(
          builder: (context, state) {
            VideoDetailsCubit cubit = context.read<VideoDetailsCubit>();
            if (state is VideoDetailsLoading) {
              return ShowLoadingIndicator();
            }
            if (state is VideoDetailsError) {
              return NoDataWidget(onclick: () {}, title: 'no_date');
            } else {
              return WillPopScope(
                onWillPop: () async {
                  cubit.updateTime().then((value) {
                    print('update time ${value.toString()}');
                  });
                  Navigator.pop(context);
                  cubit.stopRecord();
                  return Future(() => true);
                },
                child: Scaffold(
                  appBar: AppBar(
                      leading: IconButton(
                          onPressed: () {
                            context
                                .read<VideoDetailsCubit>()
                                .updateTime()
                                .then((value) {
                              print('update time');
                            });
                            cubit.stopRecord();
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.arrow_back_ios)),
                      backgroundColor: AppColors.primary,
                      title: Text(
                          cubit.videoModel != null
                              ? cubit.videoModel!.name
                              : '',
                          style: TextStyle(
                              color: AppColors.white, fontFamily: 'Cairo'))),
                  body: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Positioned(
                        top: 0,
                        right: 0,
                        left: 0,
                        bottom: cubit.pos,
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            VideoWidget(
                              videoLink: cubit.videoModel!.link,
                              videoId: cubit.videoModel!.id,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Flexible(
                                      fit: FlexFit.tight,
                                      child: Text(
                                        cubit.videoModel!.name,
                                        maxLines: 2,
                                        overflow: TextOverflow.clip,
                                        style: TextStyle(
                                          color: AppColors.black,
                                          fontFamily: 'Cairo',
                                          fontSize: getSize(context) / 22,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      )),
                                  Container(
                                      child: Row(
                                    children: [
                                      Text(
                                        cubit.videoModel!.totalWatch.toString(),
                                        style: TextStyle(
                                          color: AppColors.gray1,
                                          fontSize: getSize(context) / 28,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 7,
                                      ),
                                      MySvgWidget(
                                        path: ImageAssets.eyeIcon,
                                        imageColor: AppColors.gray1,
                                        size: getSize(context) / 18,
                                      )
                                    ],
                                  )),
                                  SizedBox(
                                    width: getSize(context) / 14,
                                  ),
                                  Container(
                                      child: Row(
                                    children: [
                                      Text(
                                        cubit.videoModel!.totalLike.toString(),
                                        style: TextStyle(
                                          color: AppColors.gray1,
                                          fontSize: getSize(context) / 28,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 7,
                                      ),
                                      MySvgWidget(
                                        path: ImageAssets.like1Icon,
                                        imageColor:
                                            AppColors.greenDownloadColor,
                                        size: getSize(context) / 18,
                                      )
                                    ],
                                  )),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.unselectedTabColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: getSize(context) / 100),
                                        child: InkWell(
                                          onTap: () {
                                            cubit.addAndRemoveToLike(
                                                cubit.type!,
                                                cubit.videoModel!.rate == 'like'
                                                    ? 'dislike'
                                                    : 'like');
                                            //like video
                                          },
                                          child: Center(
                                            child: Column(
                                              children: [
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  width: getSize(context) / 11,
                                                  height: getSize(context) / 11,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: AppColors.blue),
                                                  child: MySvgWidget(
                                                    path: ImageAssets.like1Icon,
                                                    imageColor: cubit
                                                                .videoModel!
                                                                .rate ==
                                                            "like"
                                                        ? AppColors.red
                                                        : AppColors.white,
                                                    size: getSize(context) / 11,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 4,
                                                ),
                                                Text(
                                                  trans.tr("like"),
                                                  style: TextStyle(
                                                    fontSize:
                                                        getSize(context) / 32,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: getSize(context) / 100),
                                        child: InkWell(
                                          onTap: () {
                                            cubit.favourite(
                                                cubit.type!,
                                                cubit.videoModel!.favorite ==
                                                        'un_favorite'
                                                    ? "favorite"
                                                    : "un_favorite");
                                          },
                                          child: Center(
                                            child: Column(
                                              children: [
                                                Container(
                                                  width: getSize(context) / 11,
                                                  height: getSize(context) / 11,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: AppColors.orange),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: MySvgWidget(
                                                      path:
                                                          ImageAssets.heartIcon,
                                                      imageColor: cubit
                                                                  .videoModel!
                                                                  .favorite ==
                                                              "un_favorite"
                                                          ? AppColors.white
                                                          : AppColors.red,
                                                      size:
                                                          getSize(context) / 11,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 4,
                                                ),
                                                Text(
                                                  trans.tr("favourite"),
                                                  style: TextStyle(
                                                    fontSize:
                                                        getSize(context) / 32,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                   File(cubit.dirpath.path +
                                                           "/videos/" +
                                                            cubit. videoModel!.name.split("/").toList().last +
                                                           '.mp4' ) .existsSync()
                                      ?Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: getSize(context) / 100),
                                        child: InkWell(
                                          onTap: () {
                                            cubit.downloadvideo();
                                          },
                                          child: Center(
                                            child: Column(
                                              children: [
                                                Container(
                                                  width: getSize(context) / 11,
                                                  height: getSize(context) / 11,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: AppColors.purple1),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: cubit.videoModel!
                                                                .progress !=
                                                            0
                                                        ? CircularProgressIndicator(
                                                            value: cubit
                                                                .videoModel!
                                                                .progress,
                                                            backgroundColor:
                                                                AppColors.white,
                                                            color: AppColors
                                                                .primary,
                                                          )
                                                        : MySvgWidget(
                                                            path: ImageAssets
                                                                .dowanload1Icon,
                                                            imageColor:
                                                                AppColors.white,
                                                            size: getSize(
                                                                    context) /
                                                                11,
                                                          ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 4,
                                                ),
                                                Text(
                                                  trans.tr("dowanload"),
                                                  style: TextStyle(
                                                    fontSize:
                                                        getSize(context) / 32,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ):
                                      Icon(Icons.check_circle,color: AppColors.success,),
                                      Visibility(
                                        visible:
                                            cubit.type == "video_resource" ||
                                                    cubit.type == 'video_basic'
                                                ? false
                                                : true,
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.pushNamed(context,
                                                Routes.attachmentScreen,
                                                arguments: cubit.videoModel);
                                          },
                                          child: Center(
                                            child: Column(
                                              children: [
                                                Container(
                                                  width: getSize(context) / 11,
                                                  height: getSize(context) / 11,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: AppColors.primary),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: MySvgWidget(
                                                      path: ImageAssets
                                                          .attachmentIcon,
                                                      imageColor:
                                                          AppColors.white,
                                                      size:
                                                          getSize(context) / 11,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 4,
                                                ),
                                                Text(
                                                  trans.tr("attachments"),
                                                  style: TextStyle(
                                                    fontSize:
                                                        getSize(context) / 32,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal:
                                                  getSize(context) / 22),
                                          child: CustomButton(
                                            text: trans
                                                .tr("report_about_mistake"),
                                            color: AppColors.error,
                                            onClick: () {
                                              openBottomreportSheet();
                                            },
                                          ),
                                        ),
                                      )
                                    ],
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                trans.tr("comments"),
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.blue3),
                              ),
                            ),
                            Comments(),
                          ],
                        ),
                      ),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          left: 0,
                          child: Column(
                            children: [
                              Visibility(
                                visible: cubit.isRecording,
                                child: MusicList(),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          getSize(context) / 2),
                                      child: Image.network(
                                        controller.userModel!.data!.image,
                                        height: getSize(context) / 10,
                                        width: getSize(context) / 10,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Image.asset(
                                            ImageAssets.userImage,
                                            height: getSize(context) / 10,
                                            width: getSize(context) / 10,
                                            fit: BoxFit.cover,
                                          );
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      child: CustomTextField(
                                        // minLine: 1,
                                        maxLines: 4,
                                        title: trans.tr('add_comment'),
                                        controller: cubit.comment_control,
                                        validatorMessage:
                                            trans.tr('add_comment_valid'),
                                        backgroundColor:
                                            AppColors.commentBackground,
                                        color1: AppColors.secondPrimary,
                                        onchange: (p0) {
                                          cubit.updateicone();
                                        },
                                        suffixWidget: cubit.isRecording
                                            ? Container(
                                                child: InkWell(
                                                    onTap: () {
                                                      cubit.stopRecord();
                                                    },
                                                    child: Icon(Icons.close,
                                                        color: AppColors.red)))
                                            : InkWell(
                                                onTap: () {
                                                  showDialog(
                                                    context: context,
                                                    builder: (ctx) =>
                                                        AlertDialog(
                                                      title: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                vertical: 5),
                                                        child: Text(
                                                            trans.tr('choose')),
                                                      ),
                                                      contentPadding:
                                                          EdgeInsets.zero,
                                                      content: SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width -
                                                            60,
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            ChooseIconDialog(
                                                              title: trans
                                                                  .tr('camera'),
                                                              icon: Icons
                                                                  .camera_alt,
                                                              onTap: () {
                                                                cubit.pickImage(
                                                                    type:
                                                                        'camera',
                                                                    type1: '1');
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                                // Future.delayed(Duration(milliseconds: 500),
                                                                //         () {
                                                                //       showDialog(
                                                                //         context: context,
                                                                //         barrierDismissible: false,
                                                                //         builder: (ctx) => AlertDialog(
                                                                //           title: Padding(
                                                                //             padding: const EdgeInsets.symmetric(
                                                                //               vertical: 5,
                                                                //             ),
                                                                //             child: Text('photo'.tr()),
                                                                //           ),
                                                                //           contentPadding: EdgeInsets.zero,
                                                                //           content: RecordWidget(
                                                                //             type: 'image',
                                                                //             sendType: type,
                                                                //             id: id,
                                                                //           ),
                                                                //         ),
                                                                //       );
                                                                //     });
                                                              },
                                                            ),
                                                            ChooseIconDialog(
                                                              title: trans
                                                                  .tr('photo'),
                                                              icon: Icons.photo,
                                                              onTap: () {
                                                                cubit.pickImage(
                                                                    type:
                                                                        'photo',
                                                                    type1: '1');
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                                // Future.delayed(Duration(milliseconds: 500),
                                                                //         () {
                                                                //       showDialog(
                                                                //         context: context,
                                                                //         barrierDismissible: false,
                                                                //         builder: (ctx) => AlertDialog(
                                                                //           title: Padding(
                                                                //             padding: const EdgeInsets.symmetric(
                                                                //               vertical: 5,
                                                                //             ),
                                                                //             child: Text('photo'.tr()),
                                                                //           ),
                                                                //           contentPadding: EdgeInsets.zero,
                                                                //           content: RecordWidget(
                                                                //             type: 'image',
                                                                //             sendType: type,
                                                                //             id: id,
                                                                //           ),
                                                                //         ),
                                                                //       );
                                                                //     });
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Text(trans
                                                              .tr('cancel')),
                                                        )
                                                      ],
                                                    ),
                                                  );
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: MySvgWidget(
                                                    path: ImageAssets
                                                        .attachmentIcon,
                                                    imageColor: AppColors.white,
                                                    size: 10,
                                                  ),
                                                ),
                                              ),
                                        textInputType: TextInputType.text,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        cubit.comment_control.text.isNotEmpty
                                            ? cubit.addcommment("text", '', '')
                                            : cubit.isRecording
                                                ? cubit.stop(1)
                                                : cubit.start();
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: AppColors.blue4),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Icon(
                                            cubit.comment_control.text
                                                    .isNotEmpty
                                                ? Icons.send
                                                : cubit.isRecording
                                                    ? Icons.stop
                                                    : Icons.mic,
                                            color: AppColors.white,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ))
                    ],
                  ),
                ),
              );
            }
          },
        );
      },
    );
  }

  void openBottomreportSheet() {
    git.Get.bottomSheet(
      Report(),
      backgroundColor: Colors.white,
      elevation: 8,
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.circular(40),
      // ),
    );
  }
}
