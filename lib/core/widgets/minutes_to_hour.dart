String convertMinutesToTime(int minutes) {
  int hours = minutes ~/ 60;
  int remainingMinutes = minutes % 60;
  int seconds = remainingMinutes * 60;
  String formattedTime =
      '${hours.toString().padLeft(2, '0')}:${remainingMinutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  return formattedTime;
}
