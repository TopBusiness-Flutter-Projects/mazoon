import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:new_mazoon/core/utils/getsize.dart';
import '../../../core/models/audiolessonmodel.dart';
import '../widget/audio_player.dart';

class AudioViewScreen extends StatefulWidget {
  AudioViewScreen(
      {required this.audioLessonData, required this.index, super.key});

  List<LessonAudioData> audioLessonData;
  int index;
  @override
  State<AudioViewScreen> createState() => _AudioViewScreenState();
}

class _AudioViewScreenState extends State<AudioViewScreen> {
  @override
  Widget build(BuildContext context) {
    return widget.audioLessonData[widget.index].imageOfSubjectClass == null
        ? CircularProgressIndicator()
        : Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  widget.audioLessonData[widget.index].imageOfSubjectClass!,
                ),
                onError: (exception, stackTrace) {},
                fit: BoxFit.cover,
              ),
            ),
            child: Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  leading: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back,
                      )),
                ),
                body: Stack(
                  alignment: Alignment.bottomCenter,
                  children: <Widget>[
                    Container(),
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(getSize(context) / 12),
                          topRight: Radius.circular(getSize(context) / 12)),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 30.0, sigmaY: 30.0),
                        child: Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            height: getSize(context) / 1.2,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft:
                                        Radius.circular(getSize(context) / 12),
                                    topRight: Radius.circular(
                                        getSize(context) / 12))),
                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.all(getSize(context) / 22),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        radius: getSize(context) / 12,
                                        backgroundImage: NetworkImage(widget
                                            .audioLessonData[widget.index]
                                            .imageOfSubjectClass!),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: getSize(context) / 66),
                                        child: Text(
                                          widget.audioLessonData[widget.index]
                                              .name!,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: getSize(context) / 22,
                                            fontFamily: 'Cairo',
                                            fontWeight: FontWeight.w700,
                                            height: 0,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Flexible(
                                  child: AudioPlayer2(
                                    nextPressed: () {
                                      print('nextPressed');
                                      if (widget.index >
                                          widget.audioLessonData.length - 2) {
                                        setState(() {
                                          widget.index = 0;
                                        });
                                      } else {
                                        setState(() {
                                          widget.index++;
                                        });
                                      }
                                    },
                                    previousPressed: () {
                                      print('previousPressed');
                                      if (widget.index == 0) {
                                        setState(() {
                                          widget.index =
                                              widget.audioLessonData.length - 1;
                                        });
                                      } else {
                                        setState(() {
                                          widget.index--;
                                        });
                                      }
                                    },
                                    onDelete: () {},
                                    source: widget
                                        .audioLessonData[widget.index].link!,
                                  ),
                                )
                              ],
                            )),
                      ),
                    )
                  ],
                )),
          );
  }
}
