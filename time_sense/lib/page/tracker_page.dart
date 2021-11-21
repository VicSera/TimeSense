import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:time_sense/entity/tracker.dart';
import 'package:time_sense/page/edit_tracker_page.dart';
import 'package:time_sense/service/timer_service.dart';
import 'package:time_sense/service/tracker_service.dart';
import 'package:time_sense/widget/tracker_list.dart';

class TrackerPage extends StatefulWidget {
  TrackerPage({
    Key? key,
    required this.trackerService,
    required this.timerService
  })
    : trackers = trackerService.getTrackers(), super(key: key);

  final TrackerService trackerService;
  final TimerService timerService;
  List<Tracker> trackers;

  @override
  State<TrackerPage> createState() => _TrackerPageState();
}

class _TrackerPageState extends State<TrackerPage> {
  void saveTracker(Tracker tracker) {
    setState(() {
      widget.trackerService.addTracker(tracker);
    });
  }

  void deleteTracker(Tracker tracker) {
    setState(() {
      if (tracker.id != null) {
        widget.trackerService.deleteTracker(tracker.id!);
      }
    });
  }

  void openTrackerEditPage(BuildContext context, Tracker? tracker) {
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>
            EditTrackerPage(
                tracker: tracker,
                onSave: saveTracker,
                onDelete: deleteTracker,
            ))
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trackers')
      ),
      body: TrackerList(
        trackers: widget.trackers,
        onSave: saveTracker,
        onDelete: deleteTracker,
        onClick: (tracker) => openTrackerEditPage(context, tracker),
        timerService: widget.timerService,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => openTrackerEditPage(context, null),
        child: const Icon(Icons.add)
      ),
    );
  }
}
