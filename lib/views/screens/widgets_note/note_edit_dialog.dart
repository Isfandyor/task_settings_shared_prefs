import 'package:flutter/material.dart';
import 'package:practice_2/utils/app_constants.dart';

class NoteEditDialog extends StatefulWidget {
  int index;
  NoteEditDialog({required this.index, super.key});

  @override
  State<NoteEditDialog> createState() => _NoteEditDialogState();
}

class _NoteEditDialogState extends State<NoteEditDialog> {
  final _formKey = GlobalKey<FormState>();

  String newTask = "";

  void _save() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Navigator.pop(context, {
        "task": newTask,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Edit Task"),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              maxLines: null,
              initialValue: AppConstants.listNote[widget.index].text,
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Vazifa",
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Iltimos vazifa kiriting";
                } else {
                  return null;
                }
              },
              onSaved: (newValue) {
                if (newValue != null) {
                  newTask = newValue;
                }
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Bekor qilish"),
        ),
        ElevatedButton(
          onPressed: () {
            _save();
          },
          child: const Text("Saqlash"),
        ),
      ],
    );
  }
}
