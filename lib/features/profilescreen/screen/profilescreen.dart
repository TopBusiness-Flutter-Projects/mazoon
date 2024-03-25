import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_mazoon/config/routes/app_routes.dart';
import 'package:new_mazoon/core/preferences/preferences.dart';
import 'package:new_mazoon/core/utils/app_colors.dart';
import 'package:new_mazoon/core/utils/assets_manager.dart';
import 'package:new_mazoon/core/utils/dialogs.dart';
import 'package:new_mazoon/core/widgets/custom_button.dart';
import 'package:new_mazoon/core/widgets/my_svg_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/utils/getsize.dart';
import '../../homePage/cubit/home_page_cubit.dart';
import '../../navigation_bottom/cubit/navigation_cubit.dart';
import '../../video_details/widget/choose_icon_dialog.dart';
import '../cubit/cubit.dart';
import '../cubit/state.dart';
import '../widget/profiledetailsitem.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    BlocProvider.of<ProfileCubit>(context).getProfile();
    super.initState();
  }

  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is LoadingGetUserDataState ||
            state is LoadingGetProfileState) {
          isLoading = true;
        } else {
          isLoading = false;
        }
      },
      builder: (context, state) {
        var cubit = context.read<ProfileCubit>();
        return WillPopScope(
          onWillPop: () async {
            // getUserData()  HomePageCubit PaperExamRegisterCubit
            context.read<NavigationCubit>().getUserData().then((value) {
              context.read<HomePageCubit>().getUserData().then((value) {
                context.read<HomePageCubit>().getUserData().then((value) {
                  Navigator.pop(context);
                });
              });
            });

            return false;
          },
          child: SafeArea(
            child: Scaffold(
              body: (isLoading || cubit.userModel == null)
                  ? Center(
                      child:
                          CircularProgressIndicator(color: AppColors.primary),
                    )
                  : Container(
                      child: Column(
                        children: [
                          Container(
                            height: getSize(context) / 1.8,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.only(
                                  bottomLeft:
                                      Radius.circular(getSize(context) / 8),
                                  bottomRight:
                                      Radius.circular(getSize(context) / 8),
                                )),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Positioned(
                                  right: getSize(context) / 22,
                                  top: getSize(context) / 22,
                                  child: InkWell(
                                    onTap: () async {
                                      // errorGetBar('student_report_des'.tr());
                                      await launchUrl(
                                          Uri.parse(
                                              cubit.userModel!.data!.report),
                                          mode: LaunchMode.externalApplication);
                                      // cubit.downloadReport(
                                      //     "https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf",
                                      //     context);
                                      // print('ddddd');
                                    },
                                    child: Container(
                                      width: getSize(context) / 2.8,
                                      height: getSize(context) / 10,
                                      decoration: ShapeDecoration(
                                        color: AppColors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                      ),
                                      alignment: Alignment.center,
                                      child: cubit.progresss != null
                                          ? CircularProgressIndicator()
                                          : SizedBox(
                                              width: getSize(context) / 2.8,
                                              child: Text(
                                                'student_reposrt'.tr(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: AppColors.gray1,
                                                  fontSize:
                                                      getSize(context) / 22,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ),
                                    ),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: getSize(context) / 10,
                                    ),
                                    Flexible(
                                      child: Stack(
                                        alignment: Alignment.bottomRight,
                                        children: [
                                          Container(
                                            child: CircleAvatar(
                                              backgroundColor:
                                                  AppColors.primary,
                                              radius: getSize(context) / 8,
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          getSize(context) / 2),
                                                  child: Image.network(
                                                    cubit
                                                        .userModel!.data!.image,
                                                    fit: BoxFit.cover,
                                                    height:
                                                        getSize(context) / 4,
                                                    width: getSize(context) / 4,
                                                    errorBuilder: (context,
                                                        error, stackTrace) {
                                                      return Image.asset(
                                                          ImageAssets
                                                              .userImage);
                                                    },
                                                  )),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              showDialog(
                                                context: context,
                                                builder: (ctx) => AlertDialog(
                                                  title: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(vertical: 5),
                                                    child: Text('choose'.tr()),
                                                  ),
                                                  contentPadding:
                                                      EdgeInsets.zero,
                                                  content: SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width -
                                                            60,
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        ChooseIconDialog(
                                                          title: 'camera'.tr(),
                                                          icon:
                                                              Icons.camera_alt,
                                                          onTap: () {
                                                            cubit.pickImage(
                                                              type: 'camera',
                                                            );
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                        ),
                                                        ChooseIconDialog(
                                                          title: 'photo'.tr(),
                                                          icon: Icons.photo,
                                                          onTap: () {
                                                            cubit.pickImage(
                                                              type: 'photo',
                                                            );
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child:
                                                          Text('cancel'.tr()),
                                                    )
                                                  ],
                                                ),
                                              );
                                            },
                                            //select Image from mobile and applay Edit Profile
                                            child: CircleAvatar(
                                              backgroundColor: AppColors.white,
                                              radius: getSize(context) / 20,
                                              child: MySvgWidget(
                                                  path: ImageAssets.cameraIcon,
                                                  imageColor: AppColors.primary,
                                                  size: getSize(context) / 22),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                        child: Text(
                                      cubit.userModel!.data!.name,
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        color: AppColors.white,
                                        fontSize: getSize(context) / 22,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    )),
                                    Text(
                                      Preferences.instance.getSavedLang() ==
                                              'en'
                                          ? cubit.userModel!.data!.season.nameEn
                                          : cubit
                                              .userModel!.data!.season.nameAr,
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        color: AppColors.white,
                                        fontSize: getSize(context) / 22,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                      Preferences.instance.getSavedLang() ==
                                              'en'
                                          ? cubit.userModel!.data!.term.nameEn
                                          : cubit.userModel!.data!.term.nameAr,
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        color: AppColors.orange,
                                        fontSize: getSize(context) / 24,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(height: getSize(context) / 100),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Flexible(
                              child: Container(
                            child: ListView(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              children: [
                                SizedBox(
                                  height: getSize(context) / 44,
                                ),
                                //theme UI
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.center,
                                //   children: [
                                //     Expanded(
                                //       flex: 2,
                                //       child: Container(
                                //         child: Text(
                                //           'light_mode'.tr(),
                                //           textAlign: TextAlign.center,
                                //           style: TextStyle(
                                //             color: AppColors.black,
                                //             fontSize: getSize(context) / 22,
                                //             fontWeight: FontWeight.w700,
                                //           ),
                                //         ),
                                //       ),
                                //     ),
                                //     Expanded(
                                //       child: CupertinoSwitch(
                                //           activeColor:
                                //               AppColors.liveExamGrayTextColor,
                                //           thumbColor: AppColors.switchColor,
                                //           trackColor:
                                //               AppColors.liveExamGrayTextColor,
                                //           value: ProfileCubit.mode,
                                //           onChanged: (value) {
                                //             print(ProfileCubit.mode);
                                //             cubit.changeMode(value);
                                //           }),
                                //     ),
                                //     Expanded(
                                //       flex: 2,
                                //       child: Container(
                                //         child: Text(
                                //           'dark_mode'.tr(),
                                //           textAlign: TextAlign.center,
                                //           style: TextStyle(
                                //             color: AppColors.black,
                                //             fontSize: getSize(context) / 22,
                                //             fontWeight: FontWeight.w700,
                                //           ),
                                //         ),
                                //       ),
                                //     ),
                                //   ],
                                // ),
                                SizedBox(height: getSize(context) / 22),
                                ProfileDataItem(
                                    title: 'phone_num'.tr(),
                                    data: '${cubit.userModel!.data!.phone}'),
                                ProfileDataItem(
                                    title: 'father_phone_num'.tr(),
                                    data:
                                        '${cubit.userModel!.data!.fatherPhone}'),
                                ProfileDataItem(
                                    title: 'code_num'.tr(),
                                    data: '${cubit.userModel!.data!.code}'),
                                ProfileDataItem(
                                    title: 'governorate'.tr(),
                                    data:
                                        '${Preferences.instance.getSavedLang() == 'en' ? cubit.userModel!.data!.city!.nameEn : cubit.userModel!.data!.city!.nameAr}'),
                                ProfileDataItem(
                                    title: 'city'.tr(),
                                    data:
                                        '${Preferences.instance.getSavedLang() == 'en' ? cubit.userModel!.data!.country!.nameEn : cubit.userModel!.data!.country!.nameAr}'),
                                ProfileDataItem(
                                    title: 'subtype'.tr(),
                                    data: cubit.userModel!.data!.center),
                                // cubit.userModel?.data!.dateStartCode == null
                                //     ? Container()
                                //     : ProfileDataItem(
                                //         title: 'subscription_start'.tr(),
                                //         data: DateFormat('yyyy-MM-dd').format(
                                //             cubit.userModel!.data!
                                //                 .dateStartCode!)),

                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 40.0),
                                  child: Text(
                                    'subscription_months'.tr(),
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: AppColors.liveExamGrayTextColor,
                                      fontSize: getSize(context) / 22,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                (cubit.userModel!.data!.subscriptionMonth!
                                            .isEmpty ||
                                        cubit.userModel?.data!
                                                .subscriptionMonth ==
                                            null)
                                    ? Container()
                                    : GridView.builder(
                                        padding: EdgeInsets.all(8),
                                        shrinkWrap: true,
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 4,
                                                childAspectRatio: 3 / 1.6,
                                                crossAxisSpacing: 0,
                                                mainAxisSpacing: 0),
                                        itemCount: cubit.userModel?.data!
                                            .subscriptionMonth!.length,
                                        itemBuilder: (context, index) {
                                          return Container(
                                            margin: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              color: AppColors.primary,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      getSize(context) / 88),
                                            ),
                                            alignment: Alignment.center,
                                            child: Text(
                                              cubit.userModel?.data!
                                                          .subscriptionMonth![
                                                      index] ??
                                                  '',
                                              maxLines: 1,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: AppColors.white,
                                                fontSize: getSize(context) / 28,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                // cubit.userModel?.data!.dateEndCode == null
                                //     ? Container()
                                //     : ProfileDataItem(
                                //         title: 'subscription_end'.tr(),
                                //         data: DateFormat('yyyy-MM-dd').format(
                                //             cubit.userModel!.data!
                                //                 .dateEndCode!)),

                                CustomButton(
                                    height: getSize(context) / 8,
                                    text: 'subscription_renewal'.tr(),
                                    textcolor: AppColors.white,
                                    color: AppColors.switchColor,
                                    paddingHorizontal: getSize(context) / 20,
                                    borderRadius: getSize(context) / 24,
                                    onClick: () {
                                      errorGetBar('working_on_it'.tr());
                                      // Navigator.pushNamed(context,
                                      //     Routes.selectMonthPlanPayment);

                                      ///renew
                                    }),
                                SizedBox(height: getSize(context) / 12)
                              ],
                            ),
                          ))
                        ],
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }
}
