import 'package:flutter/material.dart';

class NoteAddDialog extends StatefulWidget {
  const NoteAddDialog({super.key});

  @override
  State<NoteAddDialog> createState() => _NoteAddDialogState();
}

class _NoteAddDialogState extends State<NoteAddDialog> {
  final _formKey = GlobalKey<FormState>();

  String text = "";

  void _add() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      Navigator.pop(context, {
        "text": text,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: 1000,
        child: AlertDialog(
          title: const Text("Add To Do"),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  maxLines: null,
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
                      text = newValue;
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
                _add();
              },
              child: const Text("Qo'shish"),
            ),
          ],
        ),
      ),
    );
  }
}
