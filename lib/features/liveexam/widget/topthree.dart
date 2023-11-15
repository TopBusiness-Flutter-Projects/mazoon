// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:new_mazoon/core/models/liveheroes.dart';
import 'package:new_mazoon/core/utils/assets_manager.dart';
import 'package:new_mazoon/core/utils/getsize.dart';
import 'package:new_mazoon/core/widgets/network_image.dart';
import '../../../core/models/exam_hero.dart';
import '../../../core/utils/app_colors.dart';

class ThreeTopLiveExamHeroWidget extends StatelessWidget {
  ThreeTopLiveExamHeroWidget({required this.threeHeros, Key? key})
      : super(key: key);
  List<MyOrdered> threeHeros;
  @override
  Widget build(BuildContext context) {
    return threeHeros.length == 0
        ? Container()
        : SizedBox(
            height: getSize(context) / 1.4,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                threeHeros.length < 1
                    ? Container()
                    : Positioned(
                        left: 0,
                        right: 0,
                        top: 0,
                        child: SizedBox(
                          height: getSize(context) / 1.77,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                right: 0,
                                top: getSize(context) / 18,
                                child: Container(
                                  // width: getSize(context) / 10,
                                  height: getSize(context) / 3.3,
                                  child: Stack(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          ManageNetworkImage(
                                            imageUrl: threeHeros[0].image,
                                            height: getSize(context) / 4.8,
                                            width: getSize(context) / 4.8,
                                            borderRadius: getSize(context) / 2,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: getSize(context) / 5,
                                left: 0,
                                right: 0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: getSize(context) / 10,
                                      width: getSize(context) / 10,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            getSize(context) / 22),
                                        color: AppColors.orangeThirdPrimary,
                                      ),
                                      child: Center(
                                        child: Text(
                                          threeHeros[0].ordered.toString(),
                                          maxLines: 1,
                                          overflow: TextOverflow.clip,
                                          style: TextStyle(
                                              color: AppColors.white,
                                              fontSize: getSize(context) / 32,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                bottom: getSize(context) / 24,
                                left: 0,
                                right: 0,
                                child: Column(
                                  children: [
                                    Text(
                                      threeHeros[0].name,
                                      maxLines: 1,
                                      overflow: TextOverflow.clip,
                                      style: TextStyle(
                                        fontSize: getSize(context) / 32,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    Text(
                                      threeHeros[0].country,
                                      maxLines: 1,
                                      overflow: TextOverflow.clip,
                                      style: TextStyle(
                                        fontSize: getSize(context) / 34,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Text(
                                      '${threeHeros[0].studentTotalDegrees} / ${threeHeros[0].examsTotalDegree}',
                                      maxLines: 1,
                                      overflow: TextOverflow.clip,
                                      style: TextStyle(
                                          color: AppColors.orangeThirdPrimary,
                                          fontWeight: FontWeight.w400,
                                          fontSize: getSize(context) / 34),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                top: 0,
                                left: getSize(context) / 10,
                                right: 0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      ImageAssets.crownImage,
                                      width: getSize(context) / 8,
                                      height: getSize(context) / 8,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                SizedBox(height: getSize(context) / 4),
                threeHeros.length < 2
                    ? Container()
                    : Positioned(
                        top: getSize(context) / 4.5,
                        left: 0,
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            threeHeros.length < 2
                                ? Container()
                                : SizedBox(
                                    height: getSize(context) / 2,
                                    width: getSize(context) / 2.6,
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          left: 0,
                                          right: 0,
                                          top: 0,
                                          child: SizedBox(
                                            width: getSize(context) / 4.8,
                                            height: getSize(context) / 3.3,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                ManageNetworkImage(
                                                  imageUrl: threeHeros[1].image,
                                                  height:
                                                      getSize(context) / 4.8,
                                                  width: getSize(context) / 4.8,
                                                  borderRadius:
                                                      getSize(context) / 4.8,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          bottom: getSize(context) / 5,
                                          left: getSize(context) / 5.5,
                                          right: 0,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                height: getSize(context) / 10,
                                                width: getSize(context) / 10,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  color:
                                                      AppColors.blueLiteColor,
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    threeHeros[1]
                                                        .ordered
                                                        .toString(),
                                                    maxLines: 1,
                                                    overflow: TextOverflow.clip,
                                                    style: TextStyle(
                                                        fontSize:
                                                            getSize(context) /
                                                                32,
                                                        color: AppColors.white),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Positioned(
                                          bottom: getSize(context) / 24,
                                          left: 0,
                                          right: 0,
                                          child: Column(
                                            children: [
                                              Text(
                                                threeHeros[1].name,
                                                maxLines: 1,
                                                overflow: TextOverflow.clip,
                                                style: TextStyle(
                                                  fontSize:
                                                      getSize(context) / 32,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                threeHeros[1].country,
                                                maxLines: 1,
                                                overflow: TextOverflow.clip,
                                                style: TextStyle(
                                                    color: AppColors
                                                        .orangeThirdPrimary,
                                                    fontSize:
                                                        getSize(context) / 32),
                                              ),
                                              Text(
                                                '${threeHeros[1].studentTotalDegrees} / ${threeHeros[1].examsTotalDegree}',
                                                maxLines: 1,
                                                overflow: TextOverflow.clip,
                                                style: TextStyle(
                                                    color: AppColors
                                                        .orangeThirdPrimary,
                                                    fontSize:
                                                        getSize(context) / 32),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                            SizedBox(width: getSize(context) / 5),
                            threeHeros.length < 3
                                ? Container()
                                : SizedBox(
                                    height: getSize(context) / 2,
                                    width: getSize(context) / 2.6,
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          left: 0,
                                          right: 0,
                                          top: 0,
                                          child: SizedBox(
                                            width: getSize(context) / 4.8,
                                            height: getSize(context) / 3.3,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                ManageNetworkImage(
                                                  imageUrl: threeHeros[2].image,
                                                  height:
                                                      getSize(context) / 4.8,
                                                  width: getSize(context) / 4.8,
                                                  borderRadius:
                                                      getSize(context) / 4.8,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          bottom: getSize(context) / 5,
                                          left: getSize(context) / 5.5,
                                          right: 0,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                height: getSize(context) / 10,
                                                width: getSize(context) / 10,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  color:
                                                      AppColors.blueLiteColor,
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    threeHeros[2]
                                                        .ordered
                                                        .toString(),
                                                    maxLines: 1,
                                                    overflow: TextOverflow.clip,
                                                    style: TextStyle(
                                                        fontSize:
                                                            getSize(context) /
                                                                34,
                                                        color: AppColors.white),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Positioned(
                                          bottom: getSize(context) / 24,
                                          left: 0,
                                          right: 0,
                                          child: Column(
                                            children: [
                                              Text(
                                                threeHeros[2].name,
                                                maxLines: 1,
                                                overflow: TextOverflow.clip,
                                                style: TextStyle(
                                                  fontSize:
                                                      getSize(context) / 32,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                threeHeros[2].country,
                                                maxLines: 1,
                                                overflow: TextOverflow.clip,
                                                style: TextStyle(
                                                    color: AppColors
                                                        .orangeThirdPrimary,
                                                    fontSize:
                                                        getSize(context) / 34),
                                              ),
                                              Text(
                                                '${threeHeros[2].studentTotalDegrees} / ${threeHeros[2].examsTotalDegree}',
                                                maxLines: 1,
                                                overflow: TextOverflow.clip,
                                                style: TextStyle(
                                                    color: AppColors
                                                        .orangeThirdPrimary,
                                                    fontSize:
                                                        getSize(context) / 34),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                          ],
                        ),
                      )
              ],
            ),
          );
  }
}
