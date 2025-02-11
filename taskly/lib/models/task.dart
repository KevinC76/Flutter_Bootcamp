class Task {
  String content;
  DateTime timestamp;
  bool done;

  Task({
    required this.content,
    required this.timestamp,
    required this.done,
  });

  Map toMap() {
    return {
      'content': content,
      'timestamp': timestamp.toString(),
      'done': done,
    };
  }
}
