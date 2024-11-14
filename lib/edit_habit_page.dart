import 'package:flutter/material.dart';

class EditHabitPage extends StatefulWidget {
  final String habit;
  final String habitDetail;

  const EditHabitPage(
      {super.key, required this.habit, required this.habitDetail});

  @override
  _EditHabitPageState createState() => _EditHabitPageState();
}

class _EditHabitPageState extends State<EditHabitPage> {
  late TextEditingController _habitController;
  late TextEditingController _habitDetailController;

  @override
  void initState() {
    super.initState();
    _habitController = TextEditingController(text: widget.habit);
    _habitDetailController = TextEditingController(text: widget.habitDetail);
  }

  @override
  void dispose() {
    _habitController.dispose();
    _habitDetailController.dispose();
    super.dispose();
  }

  void _saveAndReturn() {
    Navigator.of(context).pop({
      'habit': _habitController.text,
      'habitDetail': _habitDetailController.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Habit"),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveAndReturn,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _habitController,
              decoration: const InputDecoration(labelText: "Edit your habit"),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _habitDetailController,
              decoration:
                  const InputDecoration(labelText: "Edit your habit detail"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveAndReturn,
              child: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}
