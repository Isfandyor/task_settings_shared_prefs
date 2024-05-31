import 'package:flutter/material.dart';
import 'package:practice_2/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class NoteListItem extends StatefulWidget {
  int index;
  String text;
  final Function() delete;
  final Function() edit;
  NoteListItem({
    required this.index,
    required this.edit,
    required this.delete,
    required this.text,
    super.key,
  });

  @override
  State<NoteListItem> createState() => _NoteListItemState();
}

class _NoteListItemState extends State<NoteListItem> {
  double? fontSize;

  Future<void> saveDouble(String key, double value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble(key, value);
  }

  Future<double?> getDouble(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(key);
  }

  @override
  void initState() {
    super.initState();
    _loadFontSize();
  }

  void _loadFontSize() async {
    double? size = await getDouble("fontSize");
    setState(() {
      fontSize = size ?? 16.0; // Default font size if none is saved
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 80,

      padding: const EdgeInsets.all(15),
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
              Text(
                widget.text,
                style: TextStyle(fontSize: fontSize),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
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
              Text(
                AppConstants.listNote[widget.index].dateTime
                    .toString()
                    .substring(0, 16),
                style: const TextStyle(color: Colors.indigo),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
