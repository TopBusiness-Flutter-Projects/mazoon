import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../core/utils/assets_manager.dart';
import '../../../../../core/widgets/circle_image_widget.dart';
import '../../../config/routes/app_routes.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/call_method.dart';
import '../../../core/utils/getsize.dart';
import '../../../core/utils/show_dialog.dart';
import '../../../core/utils/toast_message_method.dart';
import '../../../core/widgets/custom_button.dart';
import '../cubit/login_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _userScreenState();
}

class _userScreenState extends State<LoginScreen> {
  final keyForm = GlobalKey<FormState>();
  bool isLoading = false;
  final GlobalKey _one = GlobalKey();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _isFirstLanuch().then((value) {
        if (value) {
          ShowCaseWidget.of(context).startShowCase([_one]);
        }
      });
    });
    super.initState();
  }

  Future<bool> _isFirstLanuch() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    bool isFirstLanched = sharedPreferences.getBool('login_call') ?? true;
    if (isFirstLanched) sharedPreferences.setBool('login_call', false);
    return isFirstLanched;
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 1.5;
    return Scaffold(
      body: SafeArea(
          top: false,
          maintainBottomViewPadding: true,
          child: CircleImageWidget(
            myWidget: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: getSize(context) / 3,
                  ),
                  Hero(
                    tag: 'logo',
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                      child: Image.asset('assets/images/logo2.png',
                          width: getSize(context) / 1.2,
                          height: getSize(context) / 1.8),
                    ),
                  ),

                  BlocConsumer<LoginCubit, LoginState>(
                    listener: (context, state) {
                      if (state is userLoading) {
                        isLoading = true;
                      } else {
                        isLoading = false;
                      }
                    },
                    builder: (context, state) {
                      return isLoading
                          ? SizedBox(
                              height: getSize(context) / 3,
                              child: Center(
                                  child: CircularProgressIndicator(
                                      color: AppColors.primary)))
                          : Form(
                              key: keyForm,
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.primary,
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                              height: getSize(context) / 32),
                                          Text(
                                            'user_account'.tr(),
                                            style: TextStyle(
                                                color: AppColors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize:
                                                    getSize(context) / 24),
                                          ),
                                          SizedBox(
                                              height: getSize(context) / 32),
                                          Text(
                                            'please_write_code'.tr(),
                                            style: TextStyle(
                                                color: AppColors.white,
                                                fontWeight: FontWeight.normal,
                                                fontSize:
                                                    getSize(context) / 32),
                                          ),
                                          Container(
                                            child: Row(
                                              children: [
                                                const SizedBox(width: 25),
                                                Expanded(
                                                  child: TextFormField(
                                                    maxLines: 1,
                                                    autofocus: false,
                                                    textAlign: TextAlign.center,
                                                    controller: context
                                                        .read<LoginCubit>()
                                                        .codeController,
                                                    cursorColor:
                                                        AppColors.primary,
                                                    keyboardType:
                                                        TextInputType.text,
                                                    obscureText: true,
                                                    textInputAction:
                                                        TextInputAction.done,
                                                    decoration: InputDecoration(
                                                      hintText:
                                                          'enter_code'.tr(),
                                                      hintStyle: TextStyle(
                                                        fontFamily: 'Cairo',
                                                        fontSize:
                                                            getSize(context) /
                                                                34,
                                                        color: AppColors
                                                            .unselectedTabColor,
                                                        fontWeight:
                                                            FontWeight.w100,
                                                      ),
                                                      border: InputBorder.none,
                                                    ),
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return 'field_required'
                                                            .tr();
                                                      } else {
                                                        return null;
                                                      }
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Divider(
                                            color: AppColors.white,
                                            height: 3,
                                            thickness: 3,
                                          ),
                                          SizedBox(
                                              height: getSize(context) / 32),
                                          CustomButton(
                                            text: 'user'.tr(),
                                            textcolor: AppColors.white,
                                            color: AppColors.orangeThirdPrimary,
                                            onClick: () {
                                              if (keyForm.currentState!
                                                  .validate()) {
                                                // loadingDialog();
                                                context
                                                    .read<LoginCubit>()
                                                    .userWithCode(context);
                                              }
                                            },
                                            paddingHorizontal:
                                                getSize(context) / 14,
                                            borderRadius: getSize(context) / 12,
                                          ),
                                          SizedBox(
                                              height: getSize(context) / 32),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                    },
                  ),
                  SizedBox(height: 30),
                  Text(
                    'contact_us_from'.tr(),
                    style: TextStyle(
                      color: AppColors.gray1,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(height: 30),
                  BlocBuilder<LoginCubit, LoginState>(
                    builder: (context, state) {
                      LoginCubit cubit = context.read<LoginCubit>();
                      return SizedBox(
                        width: double.maxFinite,
                        child: Center(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    if (state is userCommunicationError) {
                                      createProgressDialog(
                                          context, 'wait'.tr());
                                      cubit.getCommunicationData().whenComplete(
                                        () {
                                          Navigator.of(context).pop();
                                          if (cubit.isCommunicationData) {
                                            getCommunicationTab(
                                              'facebook',
                                              cubit,
                                            );
                                          } else {
                                            toastMessage(
                                              'error_to_get_data'.tr(),
                                              context,
                                              color: AppColors.error,
                                            );
                                          }
                                        },
                                      );
                                    } else {
                                      getCommunicationTab(
                                        'facebook',
                                        cubit,
                                      );
                                    }
                                  },
                                  child: Image.asset(
                                    ImageAssets.facebookImage,
                                    width: getSize(context) / 12,
                                    height: getSize(context) / 12,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: 16.0),
                                InkWell(
                                  onTap: () async {
                                    if (state is userCommunicationError) {
                                      createProgressDialog(
                                          context, 'wait'.tr());
                                      cubit.getCommunicationData().whenComplete(
                                        () {
                                          Navigator.of(context).pop();
                                          if (cubit.isCommunicationData) {
                                            getCommunicationTab(
                                              'twitter',
                                              cubit,
                                            );
                                          } else {
                                            toastMessage(
                                              'error_to_get_data'.tr(),
                                              context,
                                              color: AppColors.error,
                                            );
                                          }
                                        },
                                      );
                                    } else {
                                      getCommunicationTab(
                                        'twitter',
                                        cubit,
                                      );
                                    }
                                  },
                                  child: Image.asset(
                                    ImageAssets.twitterImage,
                                    width: getSize(context) / 12,
                                    height: getSize(context) / 12,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: 16.0),
                                InkWell(
                                  onTap: () async {
                                    if (state is userCommunicationError) {
                                      createProgressDialog(
                                          context, 'wait'.tr());
                                      cubit.getCommunicationData().whenComplete(
                                        () {
                                          Navigator.of(context).pop();
                                          if (cubit.isCommunicationData) {
                                            getCommunicationTab(
                                              'instagram',
                                              cubit,
                                            );
                                          } else {
                                            toastMessage(
                                              'error_to_get_data'.tr(),
                                              context,
                                              color: AppColors.error,
                                            );
                                          }
                                        },
                                      );
                                    } else {
                                      getCommunicationTab(
                                        'instagram',
                                        cubit,
                                      );
                                    }
                                  },
                                  child: Image.asset(
                                    ImageAssets.instagramImage,
                                    width: getSize(context) / 12,
                                    height: getSize(context) / 12,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: 16.0),
                                InkWell(
                                  onTap: () async {
                                    if (state is userCommunicationError) {
                                      createProgressDialog(
                                          context, 'wait'.tr());
                                      cubit.getCommunicationData().whenComplete(
                                        () {
                                          Navigator.of(context).pop();
                                          if (cubit.isCommunicationData) {
                                            getCommunicationTab(
                                              'website',
                                              cubit,
                                            );
                                          } else {
                                            toastMessage(
                                              'error_to_get_data'.tr(),
                                              context,
                                              color: AppColors.error,
                                            );
                                          }
                                        },
                                      );
                                    } else {
                                      getCommunicationTab(
                                        'website',
                                        cubit,
                                      );
                                    }
                                  },
                                  child: Image.asset(
                                    ImageAssets.websiteImage,
                                    width: getSize(context) / 12,
                                    height: getSize(context) / 12,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: 16.0),
                                InkWell(
                                  onTap: () async {
                                    if (state is userCommunicationError) {
                                      createProgressDialog(
                                          context, 'wait'.tr());
                                      cubit.getCommunicationData().whenComplete(
                                        () {
                                          Navigator.of(context).pop();
                                          if (cubit.isCommunicationData) {
                                            getCommunicationTab(
                                              'youtube',
                                              cubit,
                                            );
                                          } else {
                                            toastMessage(
                                              'error_to_get_data'.tr(),
                                              context,
                                              color: AppColors.error,
                                            );
                                          }
                                        },
                                      );
                                    } else {
                                      getCommunicationTab(
                                        'youtube',
                                        cubit,
                                      );
                                    }
                                  },
                                  child: Image.asset(
                                    ImageAssets.youtubeImage,
                                    width: getSize(context) / 12,
                                    height: getSize(context) / 12,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: 16.0),
                                Showcase(
                                  key: _one,
                                  title: "call_us".tr(),
                                  description: 'click_call'.tr(),
                                  child: InkWell(
                                    onTap: () {
                                      if (state is userCommunicationError) {
                                        createProgressDialog(
                                            context, 'wait'.tr());
                                        cubit
                                            .getCommunicationData()
                                            .whenComplete(
                                          () {
                                            Navigator.of(context).pop();
                                            if (cubit.isCommunicationData) {
                                              getCommunicationTab(
                                                  'call', cubit);
                                            } else {
                                              toastMessage(
                                                'error_to_get_data'.tr(),
                                                context,
                                                color: AppColors.error,
                                              );
                                            }
                                          },
                                        );
                                      } else {
                                        getCommunicationTab('call', cubit);
                                      }
                                    },
                                    child: Image.asset(
                                      ImageAssets.callImage,
                                      width: getSize(context) / 12,
                                      height: getSize(context) / 12,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: getSize(context) / 8,
                  ),
                  // Container(
                  //   width: double.infinity,
                  //   // color: AppColors.white,
                  //   child: Image.asset(
                  //     ImageAssets.copyRight,
                  //     width: getSize(context) / 1.2,
                  //   ),
                  // )
                ],
              ),
            ),
          )),
    );
  }

  getCommunicationTab(String type, LoginCubit cubit) async {
    if (type == 'facebook') {
      await launchUrl(Uri.parse(cubit.communicationData!.facebookLink ?? ''),
          mode: LaunchMode.externalApplication);
    } else if (type == 'youtube') {
      await launchUrl(Uri.parse(cubit.communicationData!.youtubeLink ?? ''),
          mode: LaunchMode.externalApplication);
    } else if (type == 'twitter') {
      await launchUrl(Uri.parse(cubit.communicationData!.twitterLink ?? ''),
          mode: LaunchMode.externalApplication);
    } else if (type == 'instagram') {
      await launchUrl(Uri.parse(cubit.communicationData!.instagramLink ?? ''),
          mode: LaunchMode.externalApplication);
    } else if (type == 'website') {
      await launchUrl(Uri.parse(cubit.communicationData!.websiteLink ?? ''),
          mode: LaunchMode.externalApplication);
    } else {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: AppColors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: AppColors.secondPrimary,
                  ),
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      'contact_us_from'.tr(),
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: getSize(context) / 22,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                    height: getSize(context) / 22,
                    width: getSize(context) - 50),
                // ...List.generate(
                //   cubit.communicationData!.phones!.length,
                //   (index) =>
                //   ),
                // ),
                Flexible(
                  child: Container(
                    height: getSize(context) / 1.8,
                    child: cubit.communicationData == null
                        ? Container()
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemCount: cubit.communicationData!.phones!.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                  onTap: () {
                                    phoneCallMethod(
                                      cubit.communicationData!.phones![index]
                                          .phone,
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.call,
                                          color: AppColors.blueLiteColor,
                                          size: getSize(context) / 12,
                                        ),
                                        SizedBox(width: 20),
                                        Flexible(
                                          fit: FlexFit.tight,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                cubit.communicationData!
                                                    .phones![index].phone,
                                                style: TextStyle(
                                                  fontSize:
                                                      getSize(context) / 24,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                cubit.communicationData!
                                                    .phones![index].note,
                                                style: TextStyle(
                                                    fontSize:
                                                        getSize(context) / 28),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ));
                            },
                          ),
                  ),
                ),
                SizedBox(height: getSize(context) / 22),
                InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    height: getSize(context) / 8,
                    padding: EdgeInsets.symmetric(vertical: 0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: AppColors.orangeThirdPrimary,
                    ),
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        'close'.tr(),
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    }
  }
}
