import 'dart:async';
import 'package:safe_walk_mobile/src/models/states/event.dart';

class Streamer {
  static StreamController<Event> _streamControllerEvent =
      new StreamController.broadcast();
  static StreamController<String> _streamControllerError =
      new StreamController.broadcast();

  static Stream<Event> getEventStream() {
    return _streamControllerEvent.stream;
  }

  static void putEventStream(Event event) {
    print("Event Changed:");
    print(event.eventType.toString());
    _streamControllerEvent.sink.add(event);
  }

  static Stream<String> getErrorStream() {
    return _streamControllerError.stream;
  }

  static void putErrorStream(String streamData) {
    _streamControllerError.sink.add(streamData);
  }
}
