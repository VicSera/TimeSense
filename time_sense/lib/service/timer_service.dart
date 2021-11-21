import 'dart:async';

class TimerService {
  TimerService() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) => notify());
  }

  final Map<int, Function> callbacks = {};
  Timer? timer;

  void register(int id, Function callback) {
    callbacks[id] = callback;
  }

  void notify() {
    callbacks.forEach((_, callback) => callback.call());
  }

  void remove(int id) {
    callbacks.remove(id);
  }
}
