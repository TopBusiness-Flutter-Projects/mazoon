// import 'package:flutter/services.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:pod_player/pod_player.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';

// class PlayVideoFromNetwork extends StatefulWidget {
//   PlayVideoFromNetwork(
//       {required this.link, required this.videoTumbnail, Key? key})
//       : super(key: key);
//   String link;
//   String videoTumbnail;

//   @override
//   State<PlayVideoFromNetwork> createState() => _PlayVideoFromAssetState();
// }

// class _PlayVideoFromAssetState extends State<PlayVideoFromNetwork> {
//   late final PodPlayerController controller;
//   final videoTextFieldCtr = TextEditingController();

//   @override
//   void initState() {
//     controller = PodPlayerController(
//         playVideoFrom: PlayVideoFrom.network(
//           widget.link,
//         ),
//         podPlayerConfig: const PodPlayerConfig(
//             forcedVideoFocus: true,
//             autoPlay: true,
//             isLooping: false,
//             videoQualityPriority: [720, 360]))
//       ..initialise();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AspectRatio(
//       aspectRatio: controller.videoPlayerValue!.aspectRatio,
//       child: PodVideoPlayer(
//         // matchVideoAspectRatioToFrame: true,
//         // matchFrameAspectRatioToVideo: true,
//         // onLoading: (context) => CircularProgressIndicator(),
//         backgroundColor: Colors.transparent,
//         onVideoError: () {
//           return Image.asset('assets/images/10.png');
//         },
//         controller: controller,
//         matchFrameAspectRatioToVideo: true,

//         videoThumbnail: DecorationImage(
//           onError: (exception, stackTrace) =>
//               SvgPicture.asset('assets/svg/download_video.svg'),
//           image: NetworkImage(
//             widget.videoTumbnail,
//           ),
//         ),
//         videoAspectRatio: controller.videoPlayerValue!.aspectRatio,
//         frameAspectRatio: controller.videoPlayerValue!.aspectRatio,
//         // matchFrameAspectRatioToVideo: true,
//         // matchVideoAspectRatioToFrame: true,

//         onToggleFullScreen: (isFullScreen) async {
//           if (isFullScreen) {
//             if (controller.videoPlayerValue!.size.height >
//                 controller.videoPlayerValue!.size.width) {
//             } else {
//               SystemChrome.setPreferredOrientations(
//                   [DeviceOrientation.landscapeRight]);
//             }
//           } else {
//             SystemChrome.setPreferredOrientations(
//                 [DeviceOrientation.portraitUp]);
//           }
//         },
//         podProgressBarConfig: const PodProgressBarConfig(
//           padding: kIsWeb
//               ? EdgeInsets.zero
//               : EdgeInsets.only(
//                   bottom: 10,
//                   left: 10,
//                   right: 10,
//                 ),
//           playingBarColor: Colors.orange,
//           circleHandlerColor: Colors.orange,
//           backgroundColor: Colors.blueGrey,
//         ),
//       ),
//     );
//   }
// }
