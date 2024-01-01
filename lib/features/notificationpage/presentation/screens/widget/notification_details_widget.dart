import 'package:flutter/material.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../core/models/notifications_model.dart';

class NotificationDetailsWidget extends StatelessWidget {
  final List<Color> mainColors = [
    AppColors.primary,
    AppColors.orange,
    AppColors.purple1
  ];
  final List<Color> secondaryColors = [
    AppColors.litePrimary,
    AppColors.orangelight,
    AppColors.purple1light
  ];
  NotificationDetailsWidget(
      {Key? key,
      required this.notificationModel,
      this.index = 0,
      this.seen = "not_seen"})
      : super(key: key);

  final NotificationModel notificationModel;
  int index;
  String seen;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10),
      child: Card(
        elevation: 2,
        margin: const EdgeInsets.all(8),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: secondaryColors[index],
                        borderRadius: BorderRadius.circular(10)),
                    child: Icon(
                      Icons.notifications_active,
                      color: mainColors[index],
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    notificationModel.title ?? "",
                    style: TextStyle(
                      // color: AppColors.gray1,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Visibility(
                    visible: seen == "not_seen" ? true : false,
                    child: CircleAvatar(
                      radius: 3,
                      backgroundColor: AppColors.green,
                    ),
                  )
                  // Icon(
                  //   Icons.access_time_filled_rounded,
                  //   color: AppColors.primary,
                  // ),
                  // SizedBox(width: 12),
                  // Text(
                  //   notificationModel.createdAt!,
                  //   style: TextStyle(
                  //     // color: AppColors.gray1,
                  //     fontSize: 20,
                  //     fontWeight: FontWeight.normal,
                  //   ),
                  // ),
                ],
              ),

              Text(
                notificationModel.body ?? '',
                style: TextStyle(
                  // color: AppColors.gray1,
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(notificationModel.timeOfNotification)
              //   Divider(height: 1, thickness: 1, color: AppColors.unselectedTab)
            ],
          ),
        ),
      ),
    );
  }
}
