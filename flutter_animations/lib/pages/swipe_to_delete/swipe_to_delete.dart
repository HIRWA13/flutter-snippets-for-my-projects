import 'package:flutter/material.dart';

class SwipeToDelete extends StatefulWidget {
  const SwipeToDelete({super.key});

  @override
  State<SwipeToDelete> createState() => _SwipeToDeleteState();
}

class _SwipeToDeleteState extends State<SwipeToDelete> {
  List<String> items = List.generate(7, (index) => 'Task ${index + 1}');

  void _deleteItem(int index) {
    final removedItem = items[index];
    setState(() => items.removeAt(index));

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$removedItem deleted'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () => setState(() => items.insert(index, removedItem)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Swipe To Delete')),
      backgroundColor: const Color(0xFF1B262C),
      body: ListView.builder(
        itemCount: items.length,
        padding: const EdgeInsets.all(12),
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(items[index]),
            direction: DismissDirection.endToStart,
            background: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20),
              decoration: BoxDecoration(
                color: Colors.redAccent.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.delete, color: Colors.white, size: 28),
            ),
            onDismissed: (direction) => _deleteItem(index),
            child: Card(
              color: const Color(0xFF0F4C75),
              elevation: 6,
              margin: const EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                title: Text(
                  items[index],
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
                trailing: const Icon(
                  Icons.chevron_right,
                  color: Colors.white60,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
