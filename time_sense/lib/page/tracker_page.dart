import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:time_sense/entity/tracker.dart';
import 'package:time_sense/page/edit_tracker_page.dart';
import 'package:time_sense/service/tracker_service.dart';
import 'package:time_sense/widget/tracker_list.dart';

class TrackerPage extends StatefulWidget {
  TrackerPage({Key? key, required this.trackerService})
    : trackers = trackerService.getTrackers(), super(key: key);

  final TrackerService trackerService;
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

  void openTrackerEditPage(BuildContext context, Tracker? tracker) {
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>
            EditTrackerPage(tracker: tracker, onSave: saveTracker))
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
        onClick: (tracker) => openTrackerEditPage(context, tracker),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => openTrackerEditPage(context, null),
        child: const Icon(Icons.add)
      ),
    );
  }
}
