import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/assets_manager.dart';
import '../utils/getsize.dart';

class ManageNetworkImage extends StatelessWidget {
  const ManageNetworkImage(
      {Key? key,
      required this.imageUrl,
      this.height = 0,
      this.width = 0,
      this.borderRadius = 12})
      : super(key: key);

  final String imageUrl;
  final double height;
  final double width;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      alignment: Alignment.center,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.fitHeight,
          height: height != 0 ? height : null,
          width: width != 0 ? width : null,
          errorWidget: (context, error, stackTrace) {
            return Image.asset(
              ImageAssets.userImage,
              height: getSize(context) / 6,
              width: getSize(context) / 4,
              fit: BoxFit.cover,
            );
          },
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(
              color: AppColors.primary,
            ),
          ),
        ),
      ),
    );
  }
}
