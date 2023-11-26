import 'dart:async';

class AutoRefreshTimer {
  Timer? currentTimer;
  static AutoRefreshTimer? autoRefreshTimerClass;
  static AutoRefreshTimer get instance => AutoRefreshTimer.autoRefreshTimerClass ??= AutoRefreshTimer();

  void autoRefresh300Seconds() {
    currentTimer =
        new Timer.periodic(Duration(seconds: 300), (Timer timer) async {
      //Streamer.putEventStream(Event(EventType.REFRESH_ALL_PAGES));
      try {} catch (error) {
        print("ERROR in AutoRefresh Timer");
        print(error);
      }
    });
  }

  void stopTimer() {
    currentTimer?.cancel();
    AutoRefreshTimer.setNullInstance();
  }

  static setNullInstance() {
    AutoRefreshTimer.autoRefreshTimerClass = null;
  }
}
