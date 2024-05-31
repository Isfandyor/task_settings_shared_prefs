import 'package:flutter/material.dart';
import 'package:practice_2/controllers/note_controller.dart';
import 'package:practice_2/views/screens/widgets_note/note_add_dialog.dart';
import 'package:practice_2/views/screens/widgets_note/note_edit_dialog.dart';
import 'package:practice_2/views/screens/widgets_note/note_list_item.dart';

class TabSecond extends StatefulWidget {
  const TabSecond({super.key});

  @override
  State<TabSecond> createState() => _TabSecondState();
}

class _TabSecondState extends State<TabSecond> {
  var noteController = NoteController();

  void deleteTask(indx) {
    noteController.delete(indx);
    setState(() {});
  }

  void editTask(int index) async {
    Map<String, dynamic> data = await showDialog(
        context: context,
        builder: (ctx) {
          return NoteEditDialog(
            index: index,
          );
        });

    noteController.edit(data["task"], index);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: noteController.list.length,
            itemBuilder: (context, index) {
              return NoteListItem(
                  index: index,
                  edit: () {
                    editTask(index);
                  },
                  delete: () {
                    deleteTask(index);
                  },
                  text: noteController.list[index].text);
            },
          ),
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: FloatingActionButton(
              backgroundColor: Colors.blue[200],
              onPressed: () async {
                Map<String, dynamic> data = await showDialog(
                    context: context,
                    builder: (ctx) {
                      return const NoteAddDialog();
                    });
                noteController.add(data["text"]);
                setState(() {});
              },
              child: const Icon(Icons.add),
            ),
          ),
        ),
      ],
    );
  }
}
