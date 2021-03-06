import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:time_sense/entity/tracker.dart';
import 'package:time_sense/util/shorthand.dart';
import 'package:time_sense/util/types.dart';
import 'package:time_sense/widget/dialog/confirmation_dialog.dart';
import 'package:time_sense/widget/dialog/custom_color_picker.dart';

class EditTrackerPage extends StatefulWidget {
  EditTrackerPage({
    Key? key,
    required this.onSave,
    this.onDelete,
    Tracker? tracker
  }) : tracker = tracker != null ? Tracker.clone(tracker) : Tracker(), super(key: key);

  final TrackerFunction onSave;
  final TrackerFunction? onDelete;
  final Tracker tracker;

  @override
  State<EditTrackerPage> createState() => _EditTrackerPageState();
}

class _EditTrackerPageState extends State<EditTrackerPage> {
  _EditTrackerPageState();

  final formKey = GlobalKey<FormState>();
  var enableSave = false;

  void formChanged() {
    setState(() => enableSave = formKey.currentState!.validate());
  }

  Widget trackerForm() {
    return Form(
      key: formKey,
      onChanged: formChanged,
      child: ListView(
        children: <Widget>[
          nameField(),
          descriptionField(),
          colorField()
        ],
      ),
    );
  }

  FormField<Color> colorField() {
    return FormField(builder: (FormFieldState<Color> state) =>
      Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          const Text("Color"),
          TextButton(
            onPressed: () => {
              showDialog(
                context: context,
                builder: (context) => CustomColorPicker(
                    initialColor: widget.tracker.color,
                    onConfirm: (color) => setState(() {
                      widget.tracker.color = color;
                      formChanged();
                    })
                )
              )
            },
            child:
            SizedBox(
              width: 30.0,
              height: 30.0,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: widget.tracker.color,
                  border: Border.all(color: Colors.black, width: 2)
                ),
              ),
            ),
          )
        ],
      )
    );
  }

  TextFormField descriptionField() {
    return TextFormField(
          initialValue: widget.tracker.description,
          decoration: const InputDecoration(
              label: Text("Tracker description")
          ),
          onChanged: (value) => setState(() {
            widget.tracker.description = value;
          }),
          maxLength: 120,
          validator: (value) => value!.length > 120 ? "Description shouldn't be longer than 30 characters" :
          value.isEmpty ? "Description shouldn't be empty" : null,
          minLines: 1,
          maxLines: 4,
        );
  }

  TextFormField nameField() {
    return TextFormField(
          initialValue: widget.tracker.name,
          decoration: const InputDecoration(
              label: Text("Tracker name")
          ),
          onChanged: (value) => setState(() {
            widget.tracker.name = value;
          }),
          maxLength: 30,
          validator: (value) =>
          value!.length > 30 ? "Name shouldn't be longer than 30 characters" :
          value.isEmpty ? "Name shouldn't be empty" : null,
        );
  }

  List<Widget> footerButtons() {
    var saveButton = TextButton(
        onPressed: enableSave? () {
          widget.onSave(widget.tracker);
          Navigator.pop(context);
        } : null,
        child: const Text("Save")
    );
    var deleteButton = getDeleteButton();

    return widget.tracker.id == null? [saveButton] : [deleteButton, saveButton];
  }

  TextButton getDeleteButton() {
    return TextButton(
      onPressed: () => confirmationDialog(
          context: context,
          confirmationMessage: "Are you sure you want to delete this tracker?",
          onConfirm: () {
            widget.onDelete!(widget.tracker);
            Navigator.pop(context);
          }
      ),
      child: const Text("Delete",
        style: TextStyle(color: Colors.redAccent)
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.tracker.id == null? "Create new tracker" : "Edit tracker"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            Expanded(child: trackerForm()),

            logNowButton()
          ],
        )
      ),
      persistentFooterButtons: footerButtons(),
    );
  }

  ElevatedButton logNowButton() {
    return ElevatedButton(
      onPressed: () => confirmationDialog(
          context: context,
          confirmationMessage: "Are you sure you want to log this activity now?",
          onConfirm: () => setState(() {
            widget.tracker.logs.add(DateTime.now());
          })
      ),
      child: const Text("Log it!")
    );
  }

}
