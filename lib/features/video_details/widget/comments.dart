import 'package:easy_localization/easy_localization.dart' as trans;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart' as git;
import 'package:new_mazoon/core/models/comment_data_model.dart';
import 'package:new_mazoon/core/utils/getsize.dart';
import 'package:new_mazoon/core/widgets/network_image.dart';
import 'package:new_mazoon/core/widgets/no_data_widget.dart';
import 'package:new_mazoon/core/widgets/show_loading_indicator.dart';
import 'package:new_mazoon/features/video_details/cubit/video_details_cubit.dart';
import 'package:new_mazoon/features/video_details/widget/replies.dart';
import 'package:readmore/readmore.dart';

import '../../../core/models/user_model.dart';
import '../../../core/preferences/preferences.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/audio_player_widget.dart';
import '../../../core/widgets/circle_network_image.dart';
import '../../../core/widgets/custom_textfield.dart';

class Comments extends StatefulWidget {
  const Comments({Key? key}) : super(key: key);

  @override
  State<Comments> createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  UserModel? loginModel;
  @override
  void initState() {
    Preferences.instance.getUserModel().then((value) {
      loginModel = value;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    VideoDetailsCubit cubit = context.read<VideoDetailsCubit>();
    return loginModel == null
        ? Center(child: CircularProgressIndicator())
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocBuilder<VideoDetailsCubit, VideoDetailsState>(
              builder: (context, state) {
                if (state is CommentsLoading) {
                  return ShowLoadingIndicator();
                } else if (state is CommentsError) {
                  return NoDataWidget(
                      onclick: () {
                        cubit.getcomments(cubit.videoModel!.id, cubit.type!);
                      },
                      title: trans.tr("no_comments"));
                } else {
                  if (cubit.comments != null &&
                      cubit.comments!.data.isNotEmpty) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: cubit.comments!.data.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: InkWell(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.unselectedTabColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: ManageCircleNetworkImage(
                                              radius: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  16,
                                              imageUrl: cubit.comments!.data
                                                  .elementAt(index)
                                                  .user
                                                  .image,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  8,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  8,
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Flexible(
                                                      fit: FlexFit.tight,
                                                      child: Text(
                                                        cubit.comments!.data
                                                            .elementAt(index)
                                                            .user
                                                            .name,
                                                        overflow:
                                                            TextOverflow.clip,
                                                        maxLines: 1,
                                                        style: TextStyle(
                                                            color:
                                                                AppColors.blue3,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700),
                                                      ),
                                                    ),
                                                    Align(
                                                        alignment:
                                                            Alignment.topCenter,
                                                        child: Text(
                                                          cubit.comments!.data
                                                              .elementAt(index)
                                                              .time,
                                                          overflow:
                                                              TextOverflow.clip,
                                                          style: TextStyle(
                                                            color: AppColors
                                                                .orange,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ))
                                                  ],
                                                ),
                                                cubit.comments!.data
                                                            .elementAt(index)
                                                            .type ==
                                                        'text'
                                                    ? ReadMoreText(
                                                        cubit.comments!.data
                                                            .elementAt(index)
                                                            .comment,
                                                        trimLines: 3,
                                                        colorClickableText:
                                                            AppColors
                                                                .unselectedTabColor,
                                                        trimMode: TrimMode.Line,
                                                        lessStyle: TextStyle(
                                                            color:
                                                                AppColors.blue3,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: getSize(
                                                                    context) /
                                                                30),
                                                        trimCollapsedText: trans
                                                            .tr('see_more'),
                                                        trimExpandedText: trans
                                                            .tr('see_less'),
                                                        moreStyle: TextStyle(
                                                            color:
                                                                AppColors.blue3,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: getSize(
                                                                    context) /
                                                                30),
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color:
                                                                AppColors.gray1,
                                                            fontSize: getSize(
                                                                    context) /
                                                                24),
                                                      )
                                                    : cubit.comments!.data
                                                                .elementAt(
                                                                    index)
                                                                .type ==
                                                            'file'
                                                        ? ManageNetworkImage(
                                                            imageUrl: cubit
                                                                .comments!.data
                                                                .elementAt(
                                                                    index)
                                                                .image)
                                                        : AudioPlayer(
                                                            source: cubit
                                                                .comments!.data
                                                                .elementAt(
                                                                    index)
                                                                .audio,
                                                            onDelete: () {},
                                                            type: 'onlyShow',
                                                          )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Align(
                                        alignment:
                                            trans.EasyLocalization.of(context)!
                                                        .currentLocale!
                                                        .languageCode ==
                                                    'ar'
                                                ? Alignment.bottomLeft
                                                : Alignment.bottomRight,
                                        child: Row(
                                          children: [
                                            Expanded(child: Container()),
                                            cubit.comments!.data[index].user.id
                                                        .toString() !=
                                                    loginModel!.data!.id
                                                        .toString()
                                                ? Container()
                                                : InkWell(
                                                    onTap: () {
                                                      cubit.showEdittext(index);
                                                    },
                                                    child: Visibility(
                                                      visible: cubit.comments!
                                                                  .data
                                                                  .elementAt(
                                                                      index)
                                                                  .type ==
                                                              'text'
                                                          ? true
                                                          : false,
                                                      child: Align(
                                                          alignment: trans.EasyLocalization.of(
                                                                          context)!
                                                                      .currentLocale!
                                                                      .languageCode ==
                                                                  'ar'
                                                              ? Alignment
                                                                  .bottomLeft
                                                              : Alignment
                                                                  .bottomRight,
                                                          child: Text(
                                                            trans.tr("edit"),
                                                            style: TextStyle(
                                                                fontSize: getSize(
                                                                        context) /
                                                                    32,
                                                                color: AppColors
                                                                    .primary),
                                                          )),
                                                    ),
                                                  ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            cubit.comments!.data[index].user.id
                                                        .toString() !=
                                                    loginModel!.data!.id
                                                        .toString()
                                                ? Container()
                                                : InkWell(
                                                    onTap: () {
                                                      cubit.delecomment(
                                                          cubit.comments!.data
                                                              .elementAt(index)
                                                              .id,
                                                          index);
                                                    },
                                                    child: Align(
                                                        alignment: trans.EasyLocalization.of(
                                                                        context)!
                                                                    .currentLocale!
                                                                    .languageCode ==
                                                                'ar'
                                                            ? Alignment
                                                                .bottomLeft
                                                            : Alignment
                                                                .bottomRight,
                                                        child: Text(
                                                          trans.tr("delete"),
                                                          style: TextStyle(
                                                              fontSize: getSize(
                                                                      context) /
                                                                  32,
                                                              color: AppColors
                                                                  .primary),
                                                        )),
                                                  ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Align(
                                                alignment:
                                                    trans.EasyLocalization.of(
                                                                    context)!
                                                                .currentLocale!
                                                                .languageCode ==
                                                            'ar'
                                                        ? Alignment.bottomLeft
                                                        : Alignment.bottomRight,
                                                child: InkWell(
                                                    onTap: () {
                                                      openBottomSheet(cubit
                                                          .comments!.data
                                                          .elementAt(index));
                                                    },
                                                    child: Text(
                                                      cubit.comments!.data
                                                              .elementAt(index)
                                                              .replies
                                                              .length
                                                              .toString() +
                                                          " " +
                                                          trans.tr("replies"),
                                                      style: TextStyle(
                                                          fontSize:
                                                              getSize(context) /
                                                                  32,
                                                          color: AppColors
                                                              .primary),
                                                    ))),
                                            SizedBox(
                                              width: 10,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Visibility(
                                        visible: cubit.comments!.data
                                            .elementAt(index)
                                            .show,
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: CustomTextField(
                                                color1: AppColors.secondPrimary,
                                                title: trans.tr('edit_comment'),
                                                controller:
                                                    cubit.editcomment_control,
                                                validatorMessage: trans
                                                    .tr('edit_comment_valid'),
                                                backgroundColor:
                                                    AppColors.commentBackground,
                                                textInputType:
                                                    TextInputType.text,
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                cubit.editcommment(
                                                    "text", index);
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: AppColors.blue4),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Icon(
                                                    Icons.send,
                                                    color: AppColors.white,
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return NoDataWidget(
                        onclick: () {
                          cubit.getcomments(cubit.videoModel!.id, cubit.type!);
                        },
                        title: trans.tr('no_comments'));
                  }
                }
              },
            ),
          );
  }

  void openBottomSheet(CommentsModel commentsModel) {
    context.read<VideoDetailsCubit>().commentsModel = commentsModel;

    git.Get.bottomSheet(
      Replies(
        loginModel: loginModel,
      ),
      backgroundColor: Colors.white,
      elevation: 8,
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.circular(40),
      // ),
    );
  }
}
