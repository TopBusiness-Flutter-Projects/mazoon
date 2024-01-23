import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_mazoon/core/models/lessons_class_model.dart';
import 'package:new_mazoon/core/models/videoModel.dart';
import 'package:new_mazoon/core/utils/dialogs.dart';
import 'package:new_mazoon/features/lessons_of_class/cubit/lessons_class_cubit.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import '../../../core/models/comment_data_model.dart';
import '../../../core/models/timeupdate.dart';
import '../../../core/remote/service.dart';
import '../../../core/utils/appwidget.dart';
part 'video_details_state.dart';

class VideoDetailsCubit extends Cubit<VideoDetailsState> {
  final ServiceApi api;
  TextEditingController report_control = TextEditingController();
  TextEditingController comment_control = TextEditingController();
  TextEditingController editcomment_control = TextEditingController();
  TextEditingController replay_control = TextEditingController();
  TextEditingController editreplay_control = TextEditingController();
  int? video_id;
  String? type;
  XFile? imageFile;
  String imagePath = '';
  String audioPath = '';
  VideoModel? videoModel;
  Comments? comments;
  CommentsModel? commentsModel;
  bool isRecording = false;
  final audioRecorder = Record();
  Stream<FileResponse>? fileStream;
  var dirpath;
  double pos = 50;

  int ishour = 0;

  Duration? duration;

  Future<void> start() async {
    try {
      if (await audioRecorder.hasPermission()) {
        await audioRecorder.start();

        isRecording = await audioRecorder.isRecording();
        pos = 200;
        emit(CommentsLoaded());
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> stop(int type) async {
    final path = await audioRecorder.stop();
    isRecording = false;
    pos = 50;
    if (type == 1) {
      addcommment("audio", '', path.toString());
    } else {
      addreplay("audio", '', path!);
    }
  }

  VideoDetailsCubit(this.api) : super(VideoDetailsInitial()) {
    getDirectionPath();
  }
  getDirectionPath() async {
    dirpath = await (Platform.isIOS
        ? getApplicationSupportDirectory()
        : getApplicationDocumentsDirectory());
  }

  Future<void> stopRecord() async {
    await audioRecorder.stop();
    isRecording = false;
    pos = 50;
    emit(StopRecordingState());
  }

  pickImage({required String type, required String type1}) async {
    imageFile = await ImagePicker().pickImage(
      source: type == 'camera' ? ImageSource.camera : ImageSource.gallery,
    );
    CroppedFile? croppedFile = await ImageCropper.platform.cropImage(
      sourcePath: imageFile!.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio7x5,
        CropAspectRatioPreset.ratio16x9
      ],
      cropStyle: CropStyle.rectangle,
      compressFormat: ImageCompressFormat.png,
      compressQuality: 90,
    );
    imagePath = croppedFile!.path;
    if (type1 == "1") {
      addcommment("file", imagePath, '');
    } else {
      addreplay("file", imagePath, '');
    }
  }

  getVideoDetails(int video_id, String type) async {
    this.video_id = video_id;
    this.type = type;
    emit(VideoDetailsLoading());
    final response = await api.getVideoDetails(video_id: video_id, type: type);
    response.fold(
      (l) => emit(VideoDetailsError()),
      (r) {
        videoModel = r.data;
        getcomments(videoModel!.id, type);
        emit(VideoDetailsLoaded());
      },
    );
  }

  getcomments(int video_id, String type) async {
    this.video_id = video_id;
    this.type = type;
    emit(CommentsLoading());
    print("loading comment");
    print('type');
    print(type);
    print(video_id);
    final response = await api.getcomments(video_id: video_id, type: type);
    response.fold(
      (l) {
        emit(CommentsError());
        print('error comment');
      },
      (r) {
        print("loaded comment");
        comments = r.comments;
        print(comments!.data.length);
        emit(CommentsLoaded());
      },
    );
  }

  void updateicone() {
    emit(CommentsLoaded());
  }

  addcommment(String type, String imagePath, String audio) async {
    final response = await api.addComments(
        videoType: this.type!,
        video_id: videoModel!.id,
        type: type,
        text: comment_control.text,
        image: imagePath,
        audio: audio);
    response.fold(
      (l) => {print(l.toString()), emit(CommentsError())},
      (r) {
        print('............................');
        print(this.type!);
        print('............................');

        comments!.data.insert(0, r.data);
        comment_control.text = '';
        imagePath = '';
        audioPath = '';
        emit(CommentsLoaded());
      },
    );
  }

  editcommment(String type, int index) async {
    final response = await api.editComments(
      comment_id: comments!.data.elementAt(index)!.id,
      type: type,
      text: editcomment_control.text,
    );
    response.fold(
      (l) => {print(l.toString()), emit(CommentsError())},
      (r) {
        comments!.data.removeAt(index);
        comments!.data.insert(index, r.data);
        editcomment_control.text = '';
        successGetBar(r.message);
        emit(CommentsLoaded());
      },
    );
  }

  // onTapOpenEdit(int index) {
  //   editcomment_control.text = comments!.data[index].comment;
  //   print(comments!.data[index].comment);
  //   emit(VideoDetailsOnTapEditLoaded());
  // }

  editreplay(String type, int index) async {
    final response = await api.editReplay(
      comment_id: commentsModel!.replies.elementAt(index).id,
      type: type,
      text: editreplay_control.text,
    );
    response.fold(
      (l) => {print(l.toString()), emit(CommentsError())},
      (r) {
        commentsModel!.replies.removeAt(index);
        commentsModel!.replies.insert(index, r.data);
        editreplay_control.text = '';

        emit(CommentsLoaded());
      },
    );
  }

  addreplay(String type, String imagePath, String audio) async {
    final response = await api.addreplay(
        comment_id: commentsModel!.id,
        type: type,
        text: replay_control.text,
        audio: audio,
        image: imagePath);
    response.fold(
      (l) => emit(CommentsError()),
      (r) {
        commentsModel!.replies.add(r.data);

        replay_control.text = '';
        emit(CommentsLoaded());
      },
    );
  }

  favourite(String type, String action) async {
    final response = await api.addToFavourite(
      action: action,
      video_id: video_id!,
      type: type,
    );
    response.fold(
      (l) => emit(VideoDetailsError()),
      (r) {
        videoModel!.favorite == "un_favorite"
            ? videoModel!.favorite = "favorite"
            : videoModel!.favorite = "un_favorite";
        emit(VideoDetailsLoaded());
      },
    );
  }

  addAndRemoveToLike(String type, String action) async {
    emit(VideoDetailsLikeLoading());

    print(type);
    final response = await api.addAndRemoveToLike(
      action: action,
      video_id: video_id!,
      type: type == 'video_part' ? 'video' : type,
    );
    response.fold(
      (l) => emit(VideoDetailsLikeError()),
      (r) {
        videoModel!.rate == "like"
            ? videoModel!.rate = "dislike"
            : videoModel!.rate = "like";
        videoModel!.rate == "like"
            ? videoModel!.totalLike++
            : videoModel!.totalLike--;
        emit(VideoDetailsLikeLoaded());
      },
    );
  }

  downloadvideo() async {
    final dio = Dio();
    var dir = await (Platform.isIOS
        ? getApplicationSupportDirectory()
        : getApplicationDocumentsDirectory());

    await dio.download(
      videoModel!.link,
      dir.path +
          "/videos/" +
          videoModel!.name.split("/").toList().last +
          '.mp4',
      onReceiveProgress: (count, total) {
        videoModel!.progress = (count / total);
        print(videoModel!.progress);
        emit(VideoDetailsLoaded());
      },
    ).whenComplete(
      () {
        successGetBar('success_download_v'.tr());
        print(videoModel!.name);
        videoModel!.progress = 0;
        emit(VideoDetailsLoaded());
      },
    );
  }

  Future<void> delecomment(int id, int index) async {
    print("lllll");
    print(id);
    final response = await api.delecomment(
      commnet_id: id,
    );
    response.fold(
      (l) => {print(l.toString()), emit(CommentsError())},
      (r) {
        if (r.code == 403) {
          successGetBar(r.message);
        } else {
          comments!.data.removeAt(index);
          successGetBar(r.message);
        }

        emit(CommentsLoaded());
      },
    );
  }

  Future<void> delereplay(int id, int index) async {
    print("lllll");
    print(id);
    final response = await api.delecomment(
      commnet_id: id,
    );
    response.fold(
      (l) => {print(l.toString()), emit(CommentsError())},
      (r) {
        commentsModel!.replies!.removeAt(index);

        emit(CommentsLoaded());
      },
    );
  }

  void showEdittext(int index) {
    CommentsModel commentsModel = comments!.data.elementAt(index);
    commentsModel.show = !commentsModel.show;
    comments!.data.removeAt(index);
    comments!.data.insert(index, commentsModel);
    emit(CommentsLoaded());
  }

  void showreplayEdittext(int index) {
    Reply reply = commentsModel!.replies.elementAt(index);
    reply.show = !reply.show;
    commentsModel!.replies.removeAt(index);
    commentsModel!.replies.insert(index, reply);
    emit(CommentsLoaded());
  }

  Future<void> report(BuildContext context) async {
    AppWidget.createProgressDialog(context, 'wait'.tr());

    final response = await api.addreport(
      video_id: videoModel!.id,
      type: type!,
      comment: report_control.text,
    );
    response.fold(
      (l) =>
          {print(l.toString()), Navigator.pop(context), Navigator.pop(context)},
      (r) {
        Navigator.pop(context);
        Navigator.pop(context);
        report_control.text = '';
        successGetBar(r.message);
        emit(CommentsLoaded());
      },
    );
  }

  void setduration(Duration duration) {
    print("<<<<<<<<<<<< start time >>>>>>>>>>>>>>");
    this.duration = duration;
    emit(CommentsLoaded());
  }

  int lessonId = 0;
  updateTime(BuildContext context) async {
    // if (type == "video_part") {
    emit(VideoUpdateTimeLoading());
    print(duration!.inSeconds.toString());
    int hours = duration!.inHours;
    int minutes = (duration!.inMinutes % 60);
    int seconds = (duration!.inSeconds % 60);
    final response = await api.updateVideoTime(
        video_id: videoModel!.id,
        minutes:
            "${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}");
    response.fold(
      (l) {
        print("<<<<<<<<<<<< updsssateTime >>>>>>>>>>>>>>");
        print(l.toString());
        emit(VideoUpdateTimeError());
        // errorGetBar(l.toString());
      },
      (r) {
        print("<<<<<<<<<<<< updateTime >>>>>>>>>>>>>>");
        getVideoDetails(video_id!, type!);
        // successGetBar(r.message);
        // context
        //     .read<LessonsClassCubit>()
        //     .getVideosofLessonsData(r.data!.videoOpened.LessonId);

        lessonId = r.data!.videoOpened.LessonId;
        emit(CommentsLoaded());
        emit(UpdateTimeDoneLoaded());
      },
    );
    // } else {
    //   print("flfkkfk");
    // }
  }
}
