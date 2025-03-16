

const String tableToDo = 'todos';
const String columnId = 'id';
const String columnDescr = 'description';
const String columnTitle = 'title';
const String columnBegined = 'isBegined';
const String columnFinished = 'isFinished';
const String columnPriority = 'priority';

class ToDo {
  late String id;
  late String description;
  late String title;
  late bool isBegined;
  late bool isFinished;
  late String priority;

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      columnId : id,
      columnDescr : description,
columnTitle : title,
columnBegined : isBegined.toString(),
columnFinished : isFinished.toString(),
columnPriority : priority
    };
    return map;
  }

  ToDo({required this.id, required this.description, required this.title, required this.isBegined, required this.isFinished, required this.priority});

  ToDo.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    description = map[columnDescr];
    title = map[columnTitle];
    isBegined = map[columnBegined] ;
    isFinished = map[columnFinished] ;
    priority = map[columnPriority];
  }
}