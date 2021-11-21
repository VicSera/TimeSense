import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:time_sense/entity/tracker.dart';
import 'package:time_sense/service/timer_service.dart';
import 'package:time_sense/util/types.dart';

class TrackerWidget extends StatefulWidget {
  const TrackerWidget({
    Key? key,
    required this.tracker,
    this.onClick,
    required this.timerService
  }) : super(key: key);

  final Tracker tracker;
  final TrackerFunction? onClick;
  final TimerService timerService;

  @override
  State<TrackerWidget> createState() => _TrackerWidgetState();
}

class _TrackerWidgetState extends State<TrackerWidget> {
  String timeSinceLastLog = "";

  void getTimeSinceLastLogText() {
    if (widget.tracker.logs.isEmpty) {
      return setState(() => timeSinceLastLog = "Not logged");
    }

    var duration = DateTime.now().difference(widget.tracker.logs.last);
    var durationString =
        "${duration.inDays}d:"
        "${duration.inHours % 24}h:"
        "${duration.inMinutes % 60}m:"
        "${duration.inSeconds % 60}s";
    return setState(() => timeSinceLastLog = durationString);
  }

  @override
  void initState() {
    super.initState();
    widget.timerService.register(widget.tracker.id!, getTimeSinceLastLogText);
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => widget.onClick!(widget.tracker),
      child: Card(
        key: widget.key,
        color: widget.tracker.color,
        child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.arrow_forward_ios),
                title: Text(widget.tracker.name,
                    style: TextStyle(color: widget.tracker.nameColor)),
                subtitle: Text(widget.tracker.description,
                    style: TextStyle(color: widget.tracker.descriptionColor)),
                trailing: Text(timeSinceLastLog),
              )
            ]
        )
      )
    );
  }

  @override
  void dispose() {
    widget.timerService.remove(widget.tracker.id!);
    super.dispose();
  }
}
