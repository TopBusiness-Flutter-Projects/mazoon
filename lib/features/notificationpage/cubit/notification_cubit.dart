import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:new_mazoon/core/utils/getsize.dart';
import 'package:new_mazoon/core/utils/show_dialog.dart';
import 'package:new_mazoon/core/widgets/network_image.dart';
import 'package:new_mazoon/features/navigation_bottom/cubit/navigation_cubit.dart';
import '../../../../core/models/notifications_model.dart';
import '../../../../core/remote/service.dart';
import '../../../config/routes/app_routes.dart';
import '../../../core/preferences/preferences.dart';
import '../../../core/utils/restart_app_class.dart';
import '../../../main.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit(this.api) : super(NotificationInitial()) {
    getAllNotification();
  }

  List<NotificationModel>? data;
  final ServiceApi api;
  // UpdateNotification? updateNotification;
  // final List<bool> switches = List.generate(3, (index) => true);

  changeSwitch(bool value, index, BuildContext context) async {
    emit(LoadingChangingSwitchCaseState());
    if (index == 0) {
      Preferences.instance.setNotiSound(status: value).then((value) {
        Preferences.instance.getNotiSound().then((value) {
          Preferences.instance.notiSound = value!;
        });
      });
    } else if (index == 1) {
      Preferences.instance.setNotiVibrate(status: value).then((value) {
        Preferences.instance.getNotiVibrate().then((value) {
          Preferences.instance.notiVisbrate = value!;
        });
      });
    } else {
      Preferences.instance.setNotiLights(status: value).then((value) {
        Preferences.instance.getNotiLights().then((value) {
          Preferences.instance.notiLight = value!;
        });
      });
    }
    channel = AndroidNotificationChannel('your_channel_id', 'Your Channel Name',
        description: 'Your Channel Description',
        importance: Importance.high,
        enableVibration: Preferences.instance.notiVisbrate,
        playSound: Preferences.instance.notiSound,
        enableLights: Preferences.instance.notiLight);
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    // print(channel.);
    print(channel.enableLights);
    print(channel.enableVibration);

    ///
    HotRestartController.performHotRestart(context);
    emit(ChangingSwitchCaseState());
  }

  getAllNotification() async {
    emit(NotificationPageLoading());
    final response = await api.getAllNotification();
    response.fold(
      (error) => emit(NotificationPageError()),
      (response) {
        data = response.data;
        emit(NotificationPageLoaded());
      },
    );
  }

  notificationUpdate(int index, BuildContext context) async {
    createProgressDialog(context, 'wait'.tr());
    emit(LoadingToUpdateState());
    final response = await api.updateNotification(data![index].id);
    response.fold((l) {
      emit(FailedToUpdateState());
      Navigator.pop(context);
    }, (r) async {
      if (r.code == 200 || r.code == 201) data![index].seen = "seen";
      data![index] = r.data!;
      emit(SuccessUpdateState());
      Navigator.pop(context);
      //couldn't check this case
      if (data![index].notificationType == "video_resource") {
        Navigator.pushNamed(context, Routes.videoDetailsScreenRoute,
            arguments: {
              'type': 'video_resource',
              'videoId': data![index].videoId,
            });
      } else if (data![index].notificationType == "video_part") {
        Navigator.pushNamed(context, Routes.videoDetailsScreenRoute,
            arguments: {
              'type': 'video_part',
              'videoId': data![index].videoId,
            });
      }
      //couldn't check this case
      else if (data![index].notificationType == "video_basic") {
        Navigator.pushNamed(context, Routes.videoDetailsScreenRoute,
            arguments: {
              'type': 'video_basic',
              'videoId': data![index].videoId,
            });
      }
      //couldn't check this case
      else if (data![index].notificationType == "all_exam") {
        Navigator.pushNamed(context, Routes.examInstructionsRoute,
            arguments: [data![index].videoId, "all_exam"]);
      }
      //couldn't check this case
      else if (data![index].notificationType == "video_part_exam") {
        Navigator.pushNamed(context, Routes.examInstructionsRoute,
            arguments: [data![index].videoId, "video"]);
      }
      //couldn't check this case
      else if (data![index].notificationType == "lesson_exam") {
        Navigator.pushNamed(context, Routes.examInstructionsRoute,
            arguments: [data![index].videoId, "lesson"]);
      }
      //couldn't check this case
      else if (data![index].notificationType == "subject_class_exam") {
        Navigator.pushNamed(context, Routes.examInstructionsRoute,
            arguments: [data![index].videoId, "online_exam"]);
      } else if (data![index].notificationType == "papel_sheet_exam") {
        await context.read<NavigationCubit>().getTimes(context);
      } else if (data![index].notificationType == "text") {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              scrollable: true,
              title: Center(child: Text("${data![index].title}")),
              content: Container(
                height: getSize(context),
                width: getSize(context),
                child: ListView(
                  // mainAxisSize: MainAxisSize.min,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    Text("${data![index].body}"),
                    data![index].image != null
                        ? ManageNetworkImage(imageUrl: data![index].image)
                        : Container()
                  ],
                ),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "close".tr(),
                    ))
              ],
            );
          },
        );
      }
      //   updateNotification = r ;
    });
  }
}
