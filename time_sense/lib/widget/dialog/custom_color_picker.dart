import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:time_sense/util/types.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class CustomColorPicker extends StatefulWidget {
  CustomColorPicker({Key? key, required this.onConfirm, Color? initialColor})
      : pickerColor = initialColor ?? Colors.deepOrange,
        super(key: key);

  final ColorChangedFunction onConfirm;
  Color pickerColor;

  @override
  State<CustomColorPicker> createState() => _CustomColorPickerState();
}

class _CustomColorPickerState extends State<CustomColorPicker> {
  void changeColor(Color color) {
    setState(() => widget.pickerColor = color);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Pick a color'),
      content: SingleChildScrollView(
        child: ColorPicker(
          pickerColor: widget.pickerColor,
          onColorChanged: changeColor,
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          child: const Text('Confirm'),
          onPressed: () {
            widget.onConfirm(widget.pickerColor);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

}
