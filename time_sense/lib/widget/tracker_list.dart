import 'package:flutter/cupertino.dart';
import 'package:time_sense/entity/tracker.dart';
import 'package:time_sense/util/types.dart';
import 'package:time_sense/widget/tracker_widget.dart';

class TrackerList extends StatefulWidget {
  const TrackerList({
    Key? key,
    required this.trackers,
    required this.onSave,
    this.onClick
  }) : super(key: key);

  final List<Tracker> trackers;
  final TrackerSavedFunction onSave;
  final TrackerClickedFunction? onClick;

  @override
  State<TrackerList> createState() => _TrackerListState();
}

class _TrackerListState extends State<TrackerList> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: widget.trackers.map((tracker) =>
          TrackerWidget(
            tracker: tracker,
            onClick: widget.onClick,
          )).toList(),
    );
  }

}
