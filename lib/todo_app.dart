import 'package:flutter/material.dart';
import 'models/todo_item.dart';
import 'widgets/todo_list_item.dart';
import 'widgets/add_todo_dialog.dart';

// StatefulWidget - Widget yang dapat berubah state-nya
class TodoApp extends StatefulWidget {
  const TodoApp({super.key});

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  // List untuk menyimpan semua todo items
  final List<TodoItem> _todoItems = [];
  
  // Controller untuk input field
  final TextEditingController _textController = TextEditingController();

  // Method untuk menambahkan todo baru
  void _addTodoItem(String title) {
    if (title.trim().isNotEmpty) {
      setState(() {
        _todoItems.add(TodoItem(title: title.trim()));
      });
    }
  }

  // Method untuk toggle status completed dari todo item
  void _toggleTodoItem(int index) {
    setState(() {
      _todoItems[index].toggleCompleted();
    });
  }

  // Method untuk menghapus todo item
  void _deleteTodoItem(int index) {
    setState(() {
      _todoItems.removeAt(index);
    });
  }

  // Method untuk menampilkan dialog tambah todo
  void _showAddTodoDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddTodoDialog(
          onAddTodo: _addTodoItem,
        );
      },
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'TodoKu',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 2,
      ),
      body: Column(
        children: [
          // Header dengan informasi jumlah tugas
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              border: Border(
                bottom: BorderSide(color: Colors.grey[300]!),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total Tugas: ${_todoItems.length}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Selesai: ${_todoItems.where((item) => item.isCompleted).length}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.green[600],
                  ),
                ),
              ],
            ),
          ),
          
          // Daftar todo items
          Expanded(
            child: _todoItems.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    itemCount: _todoItems.length,
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    itemBuilder: (context, index) {
                      return TodoListItem(
                        todoItem: _todoItems[index],
                        onToggle: () => _toggleTodoItem(index),
                        onDelete: () => _deleteTodoItem(index),
                      );
                    },
                  ),
          ),
        ],
      ),
      
      // FloatingActionButton untuk menambah todo baru
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTodoDialog,
        tooltip: 'Tambah Tugas Baru',
        child: const Icon(Icons.add),
      ),
    );
  }

  // Widget untuk menampilkan state kosong
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.task_alt,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'Belum ada tugas',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tap tombol + untuk menambah tugas baru',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }
}