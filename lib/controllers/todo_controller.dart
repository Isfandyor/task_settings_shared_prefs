import 'package:practice_2/models/todo.dart';
import 'package:practice_2/utils/app_constants.dart';

class TodoController {
  final List<Todo> _list = AppConstants.listTodo;

  void done(int indx) {
    _list[indx].isDone = !_list[indx].isDone;
  }

  List<Todo> get list {
    return [..._list];
  }

  void add(String text) {
    _list.add(Todo(text: text, isDone: false));
  }

  void delete(int indx) {
    _list.removeAt(indx);
  }

  void edit(String task, int index) {
    _list[index].text = task;
  }
}
