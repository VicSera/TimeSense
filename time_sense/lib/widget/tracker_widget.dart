import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:time_sense/entity/tracker.dart';
import 'package:time_sense/util/types.dart';

class TrackerWidget extends StatefulWidget {
  const TrackerWidget({Key? key, required this.tracker, this.onClick}) : super(key: key);

  final Tracker tracker;
  final TrackerFunction? onClick;

  @override
  State<TrackerWidget> createState() => _TrackerWidgetState();
}

class _TrackerWidgetState extends State<TrackerWidget> {
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
                trailing: const Text("15 min ago"),
              )
            ]
        )
      )
    );
  }

}
