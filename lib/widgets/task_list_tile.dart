import 'package:flutter/material.dart';
import 'package:task_manager_project/data/models/task_list_model.dart';

class TaskListTile extends StatelessWidget {
  const TaskListTile({
    super.key,
    required this.data,
    required this.onDeleteTap,
    required this.onEditTap,
  });

  final VoidCallback onDeleteTap, onEditTap;
  final TaskData data;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(data.title ?? 'Unknown'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(data.description ?? ''),
          Text(data.createdDate ?? ''),
          Row(
            children: [
              Chip(
                  label: Text(
                    "New",
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.blue),
              Spacer(),
              IconButton(
                  onPressed: onDeleteTap,
                  icon: Icon(Icons.delete_forever_outlined,
                      color: Colors.red.shade300)),
              IconButton(
                  onPressed: onEditTap,
                  icon: Icon(
                    Icons.edit,
                    color: Colors.green,
                  )),
            ],
          )
        ],
      ),
    );
  }
}
