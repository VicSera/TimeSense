import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:time_sense/entity/tracker.dart';

class TrackerService {
  List<Tracker> trackers = [
    Tracker(
        id: 1,
        name: "Activity 1",
        description: "Some activity 1",
        color: Colors.purple,
        logs: [DateTime.now().subtract(const Duration(days: 1, hours: 5, minutes: 15, seconds: 30))]
    ),
    Tracker(id: 2, name: "Activity 2", description: "Some activity 2", color: Colors.blue),
    Tracker(id: 3, name: "Activity 3", description: "Some activity 3", color: Colors.red),
    Tracker(id: 4, name: "Activity 4", description: "Some activity 4", color: Colors.green),
  ];

  int nextId = 5;

  void addTracker(Tracker tracker) {
    if (tracker.id == null) {
      trackers.add(Tracker.clone(tracker, replaceId: nextId));
      nextId++;
    } else {
      var index = trackers.indexWhere((element) => element.id == tracker.id);
      if (index != -1) {
        trackers[index] = tracker;
      }
    }
  }

  void deleteTracker(int id) {
    trackers.removeWhere((element) => element.id == id);
  }

  List<Tracker> getTrackers() {
    return trackers;
  }
}
