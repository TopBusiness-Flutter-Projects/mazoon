class EndPoints {
  static const String baseUrl = 'https://platform.egymoe.com/api/';
  // 'https://platform.egymoe.com/api/';
  //'https://elmazone.topbusiness.io/api/';
  static const String userUrl = '${baseUrl}auth/login';
  static const String onBoardingUrl = '${baseUrl}on-boarding';
  static const String homePageUrl = '${baseUrl}auth/home-page';
  static const String communicationUrl = '${baseUrl}auth/communication';
  static const String adsUrl = '${baseUrl}ads';
  static const String notificationUrl = '${baseUrl}auth/all-notifications';
  static const String notificationToken = '${baseUrl}auth/add-device-token';
  static const String updateNotificationUrl =
      '${baseUrl}auth/notification-update-status/';
  static const String explanationUrl =
      '${baseUrl}auth/home-page/start-your-journey';
  static const String examsOflesson = '/ExamEntry/all-of-questions/';
  static const String finalReviewUrl =
      '${baseUrl}auth/home-page/videos-resources';
  static const String examClassesUrl = '${baseUrl}auth/home-page/all-classes';
  static const String allExamClassesUrl = '${baseUrl}auth/home-page/all-exams';
  static const String examsClassByIdUrl =
      '${baseUrl}auth/home-page/start-your-journey/findExamByClassById/';
  static const String monthPlanUrl = '${baseUrl}plans/all';
  static const String notesUrl = '${baseUrl}notes/note-all-by-date';
  static const String datesOfNotesUrl = '${baseUrl}notes/dates-of-notes';
  static const String lessonsByClassUrl = '${baseUrl}classes/lessonsByClassId/';
  static const String VideoByLessonUrl =
      '${baseUrl}lesson/all-video-by-lessonId/';
  static const String studentReportsUrl = '${baseUrl}report/all-by-student';
  static const String ExamByLessonUrl =
      '${baseUrl}lesson/all-exams-by-lessonId/';
  static const String AudioOfLesson = '${baseUrl}lesson/all-audios-by-videoId/';
  static const String PdfOfLesson = '${baseUrl}lesson/all-pdf-by-videoId/';
  static const String homeworkOfLesson =
      '${baseUrl}lesson/all-exams-by-videoId/';
  static const String registerExamUrl = '${baseUrl}auth/papel-sheet-exam/user/';
  static const String deleteregisterExamUrl =
      '${baseUrl}auth/paper-sheet-exam/latest-paper-exam-delete';
  static const String paperExamDetialsUrl =
      '${baseUrl}auth/paper-sheet-exam/register-with-student-check-before';
  static const String timesUrl = '${baseUrl}auth/papel-sheet-exam/show';
  static const String sourcesReferencesUrl =
      '${baseUrl}guide/sources_references/all';
  static const String sourcesReferencesByIdUrl =
      '${baseUrl}guide/sources_references/by-lesson/';
  static const String examInstructionsUrl = '${baseUrl}instruction/exam/';
  static const String videoDetailsUrl = '${baseUrl}lesson/video/details/';
  static const String commentsUrl = '${baseUrl}lesson/video/comments/';
  static const String addremovefavUrl = '${baseUrl}favorite/video-add-favorite';
  static const String addremovelikeUrl = '${baseUrl}user-rate-video';
  static const String addremovefavUrlExam =
      '${baseUrl}favorite/exam-add-favorite';

  static const String addcommentsUrl = '${baseUrl}lesson/video/add-comment';
  static const String addreplayUrl = '${baseUrl}lesson/comment/add-replay/';
  static const String deletecommentUrl = '${baseUrl}video/comment/delete/';
  static const String deletereplayUrl = '${baseUrl}video/replay/delete/';
  static const String editcommentUrl = '${baseUrl}video/comment/update/';
  static const String editReplayUrl = '${baseUrl}video/replay/update/';
  static const String reportUrl = '${baseUrl}report/student-add-report';
  static const String updateVideoTimeUrl = '${baseUrl}video-update-time/';
  static const String applyLessonExam = '${baseUrl}ExamEntry/exam/';
  static const String rateYourSelf = "${baseUrl}lesson/exam-details-by-examId/";
  static const String getFavoriteAllUrl = "${baseUrl}favorite/all";
  static const String dependLessonExam =
      "${baseUrl}ExamEntry/exam-degree-depends-with-student/";

  static const String tryAtEndOfExam = "${baseUrl}access-end-time/exam/";

  static const String homeworkGrade =
      '${baseUrl}degree-details/videos-by-lesson/';
  static const String lessonsExamGrade = '${baseUrl}degree-details/lesson/';
  static const String classesExamsGrade = '${baseUrl}degree-details/class/';
  static const String countdown = '${baseUrl}auth/exam-countdown';
  static const String comprehensiveExamGrade =
      '${baseUrl}degree-details/all-exams';
  static const String addNoteByStudent = '${baseUrl}notes/note-add-by-student';

//notes/note-delete/3
  static const String deleteNoteByStudent = '${baseUrl}notes/note-delete/';

  //auth/invite-your-friends
  static const String inviteFriend = '${baseUrl}auth/invite-your-friends';

  static const String getUserProfile = '${baseUrl}auth/getProfile';

  static const String updateUserProfile = '${baseUrl}auth/update-profile';

  static const String aboutMe = '${baseUrl}teacher/about-me';

  static const String examHero = '${baseUrl}exam-heroes/all';

  static const String makeExam =
      '${baseUrl}test-yourself-exams/all-classes-with-lessons';
  static const String makeYourExam = '${baseUrl}test-yourself-exams/make-exam';

  static const String applyMakeYourExam =
      '${baseUrl}test-yourself-exams/solve-exam/';
  static const String deleteReport = '${baseUrl}report/delete/';

  static const String addNewSuggest = '${baseUrl}auth/add-suggest';
  static const String openFirstLesson = '${baseUrl}lesson/';
  static const String accessFirstVideoCustom =
      '${baseUrl}lesson/accessFirstVideoCustom';
  static const String userScreenshot = '${baseUrl}auth/user-add-screenshot';
  static const String AllMonthes = '${baseUrl}payments/all-months';
  static const String calDiscount =
      '${baseUrl}payments/check-money-paid-with-discount';
  //processed?total_after_discount=360.00
  static const String payment = '${baseUrl}processed?total_after_discount=';
  static const String liveExams = '${baseUrl}live-exam-all';

  static const String liveHeroes = '${baseUrl}live-exam/heroes/';

  static const String selectMonth = '${baseUrl}live-exam-all/choose-live-exam';
  static const String liveExamResult = '${baseUrl}live-exam/result/';

  static const String liveExamQuestions =
      '${baseUrl}live-exam/all-of-questions/';

  static const String applyLiveExam =
      '${baseUrl}live-exam/add-exam-by-student/';
}
