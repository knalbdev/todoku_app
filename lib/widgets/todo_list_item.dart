import 'package:flutter/material.dart';
import '../models/todo_item.dart';

// Widget untuk menampilkan setiap item todo dalam list
class TodoListItem extends StatelessWidget {
  final TodoItem todoItem;
  final VoidCallback onToggle;
  final VoidCallback onDelete;

  const TodoListItem({
    super.key,
    required this.todoItem,
    required this.onToggle,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: CheckboxListTile(
        title: Text(
          todoItem.title,
          style: TextStyle(
            fontSize: 16,
            decoration: todoItem.isCompleted 
                ? TextDecoration.lineThrough 
                : TextDecoration.none,
            color: todoItem.isCompleted 
                ? Colors.grey[600] 
                : Colors.black87,
          ),
        ),
        subtitle: Text(
          'Dibuat: ${_formatDateTime(todoItem.createdAt)}',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[500],
          ),
        ),
        value: todoItem.isCompleted,
        onChanged: (bool? value) {
          onToggle();
        },
        secondary: IconButton(
          icon: const Icon(
            Icons.delete,
            color: Colors.red,
          ),
          onPressed: () {
            _showDeleteConfirmation(context);
          },
          tooltip: 'Hapus tugas',
        ),
        controlAffinity: ListTileControlAffinity.leading,
      ),
    );
  }

  // Method untuk format tanggal dan waktu
  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  // Method untuk menampilkan konfirmasi hapus
  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Hapus Tugas'),
          content: Text('Apakah Anda yakin ingin menghapus tugas "${todoItem.title}"?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                onDelete();
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.red,
              ),
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );
  }
}