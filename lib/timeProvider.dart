import 'dart:async';

import 'package:flutter/material.dart';

class TimerProvider with ChangeNotifier {
  int roundNumber = 1;
  int totalTimeInSeconds = 60;
  int elapsedTimeInSeconds = 0;
  late Timer _timer;
  bool timerRunning = false;


  void startTimer() {
    timerRunning = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (elapsedTimeInSeconds < totalTimeInSeconds) {
        elapsedTimeInSeconds++;
      } else {
        // Start a new round
        roundNumber++;
        elapsedTimeInSeconds = 0;
      }
      notifyListeners();
    });
  }

  void pauseTimer() {

    _timer.cancel();
    timerRunning = false;
    notifyListeners();
  }

  void resumeTimer() {
    timerRunning = true;
    startTimer();
  }

  void cancelTimer() {
    notifyListeners();
    timerRunning = false;
    _timer.cancel();
    roundNumber = 1;
    totalTimeInSeconds = 60;
    elapsedTimeInSeconds = 0;
  }
}