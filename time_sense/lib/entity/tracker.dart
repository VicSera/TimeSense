import 'dart:ui';

import 'package:flutter/material.dart';

class Tracker {
  Tracker({
    this.id,
    this.name = "",
    this.description = "",
    this.color = Colors.deepOrange,
    this.nameColor = Colors.black,
    this.descriptionColor = Colors.black45
  });

  Tracker.clone(Tracker tracker, {int? replaceId}) :
    id = replaceId ?? tracker.id,
    name = tracker.name,
    description = tracker.description,
    color = tracker.color,
    nameColor = tracker.nameColor,
    descriptionColor = tracker.descriptionColor;

  final int? id;
  String name;
  String description;
  Color color;
  Color nameColor;
  Color descriptionColor;
}
