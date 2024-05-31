import 'package:flutter/material.dart';
import 'package:practice_2/controllers/todo_controller.dart';
import 'package:practice_2/views/screens/widgets_todo/todo_add_dialog.dart';
import 'package:practice_2/views/screens/widgets_todo/todo_edit_dialog.dart';
import 'package:practice_2/views/screens/widgets_todo/todo_list_item.dart';

class TabFirst extends StatefulWidget {
  const TabFirst({super.key});

  @override
  State<TabFirst> createState() => _TabFirstState();
}

class _TabFirstState extends State<TabFirst> {
  var todoController = TodoController();

  void deleteTask(indx) {
    todoController.delete(indx);
    setState(() {});
  }

  void editTask(int index) async {
    Map<String, dynamic> data = await showDialog(
        context: context,
        builder: (ctx) {
          return const TodoEditDialog();
        });

    todoController.edit(data["task"], index);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: todoController.list.length,
            itemBuilder: (context, index) {
              return TodoListItem(
                edit: () {
                  editTask(index);
                },
                delete: () {
                  deleteTask(index);
                },
                done: () {
                  todoController.done(index);
                  setState(() {});
                },
                text: todoController.list[index].text,
                isDone: todoController.list[index].isDone,
              );
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
                      return const TodoAddDialog();
                    });
                todoController.add(data["text"]);
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
