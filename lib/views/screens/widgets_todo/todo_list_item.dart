import 'package:flutter/material.dart';

class TodoListItem extends StatefulWidget {
  String text;
  bool isDone;
  final Function() done;
  final Function() delete;
  final Function() edit;
  TodoListItem({
    required this.edit,
    required this.delete,
    required this.done,
    required this.text,
    required this.isDone,
    super.key,
  });

  @override
  State<TodoListItem> createState() => _TodoListItemState();
}

class _TodoListItemState extends State<TodoListItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.blue[300],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: widget.done,
                icon: widget.isDone
                    ? const Icon(
                        Icons.check_box,
                        color: Color.fromARGB(255, 188, 255, 189),
                      )
                    : const Icon(
                        Icons.check_box_outline_blank_rounded,
                        color: Colors.white,
                      ),
              ),
              Text(
                widget.text,
                style: TextStyle(
                  decoration: widget.isDone ? TextDecoration.lineThrough : null,
                ),
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                onPressed: widget.edit,
                icon: const Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
              ),
              IconButton(
                onPressed: widget.delete,
                icon: const Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
