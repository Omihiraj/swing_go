List<String> getTimesDur(int sHour, int sMin, int eHour, int eMin, String dur) {
  final today = DateTime.now();
  final times = <String>[];

  final endTime = DateTime.utc(today.year, today.month, today.day, eHour, eMin);
  final startTime =
      DateTime.utc(today.year, today.month, today.day, sHour, sMin);
  int difference = endTime.difference(startTime).inMinutes;

  int duration = 15;
  if (dur == "15 Minutes") {
    duration = 15;
  } else if (dur == "30 Minutes") {
    duration = 30;
  } else if (dur == "45 Minutes") {
    duration = 45;
  } else if (dur == "01 Hour") {
    duration = 60;
  } else if (dur == "02 Hour") {
    duration = 120;
  }

  if (difference > 0) {
    int noOfTimes = difference ~/ duration;
    if ((difference % duration) == 0) {
      noOfTimes--;
    }

    times.add(sHour.toString().padLeft(2, '0') +
        ":" +
        sMin.toString().padLeft(2, '0'));
    DateTime newTime = startTime;

    for (int i = 0; i < noOfTimes; i++) {
      newTime = newTime.add(Duration(minutes: duration));
      final hour = newTime.hour.toString().padLeft(2, '0');
      final minute = newTime.minute.toString().padLeft(2, '0');
      times.add("$hour:$minute");
    }

    // print('Difference Between Times: $difference');
    // print('No of times: $noOfTimes ');
    // print(times);
    return times;
  } else {
    //print("Please Enter Valid TimeSet");

    return times;
  }
}
