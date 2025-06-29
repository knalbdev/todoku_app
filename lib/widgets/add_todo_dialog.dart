import 'package:flutter/material.dart';

// Dialog untuk menambahkan todo baru
class AddTodoDialog extends StatefulWidget {
  final Function(String) onAddTodo;

  const AddTodoDialog({
    super.key,
    required this.onAddTodo,
  });

  @override
  State<AddTodoDialog> createState() => _AddTodoDialogState();
}

class _AddTodoDialogState extends State<AddTodoDialog> {
  final TextEditingController _controller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submitTodo() {
    if (_formKey.currentState!.validate()) {
      widget.onAddTodo(_controller.text);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Tambah Tugas Baru'),
      content: Form(
        key: _formKey,
        child: TextFormField(
          controller: _controller,
          decoration: const InputDecoration(
            labelText: 'Nama tugas',
            hintText: 'Masukkan nama tugas...',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Nama tugas tidak boleh kosong';
            }
            if (value.trim().length < 3) {
              return 'Nama tugas minimal 3 karakter';
            }
            return null;
          },
          autofocus: true,
          textCapitalization: TextCapitalization.sentences,
          onFieldSubmitted: (value) {
            _submitTodo();
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Batal'),
        ),
        ElevatedButton(
          onPressed: _submitTodo,
          child: const Text('Tambah'),
        ),
      ],
    );
  }
}