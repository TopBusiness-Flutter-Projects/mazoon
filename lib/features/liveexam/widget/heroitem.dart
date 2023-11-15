import 'dart:math';

import 'package:flutter/material.dart';
import 'package:new_mazoon/core/utils/getsize.dart';
import 'package:new_mazoon/core/widgets/network_image.dart';

import '../../../core/models/liveheroes.dart';
import '../../../core/utils/app_colors.dart';

class HeroItem extends StatelessWidget {
  HeroItem({required this.model, Key? key}) : super(key: key);
  final random = Random();

  MyOrdered model;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getSize(context) / 22,
              vertical: getSize(context) / 24),
          child: Row(
            children: [
              ManageNetworkImage(
                imageUrl: model.image,
                height: getSize(context) / 5,
                width: getSize(context) / 5,
                borderRadius: getSize(context) / 24,
              ),
              Expanded(
                child: Container(
                  height: getSize(context) / 4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(getSize(context) / 22),
                    color: AppColors.redLiteColor,
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: getSize(context) / 22),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          model.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: getSize(context) / 28,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          model.country,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: getSize(context) / 32,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          '${model.studentTotalDegrees} / ${model.examsTotalDegree}',
                          style: TextStyle(
                            color: AppColors.orangeThirdPrimary,
                            fontSize: getSize(context) / 28,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Positioned(
            top: getSize(context) / 100,
            left: getSize(context) / 14,
            child: Container(
              width: getSize(context) / 12,
              height: getSize(context) / 12,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromRGBO(
                  random.nextInt(256),
                  random.nextInt(256),
                  random.nextInt(256),
                  2,
                ),
              ),
              child: Center(
                child: Text(
                  model.ordered.toString(),
                  style: TextStyle(
                      color: AppColors.white, fontSize: getSize(context) / 24),
                ),
              ),
            ))
      ],
    );
  }
}
