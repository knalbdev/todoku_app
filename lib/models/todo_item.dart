// Model class untuk merepresentasikan sebuah item todo
class TodoItem {
  String title;
  bool isCompleted;
  DateTime createdAt;

  TodoItem({
    required this.title,
    this.isCompleted = false,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  // Method untuk toggle status completed
  void toggleCompleted() {
    isCompleted = !isCompleted;
  }
}