import 'package:flutter/material.dart';
import 'package:laravel_flutter/model/task_model.dart';
import 'service/task_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskProvider(),
      child: MaterialApp(
        title: 'Flutter Laravel CRUD',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fetchTasks();
  }

  Future<void> _fetchTasks() async {
    await Provider.of<TaskProvider>(context, listen: false).fetchTasks();
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _addTask() async {
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add Task'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              // Add the new task
              final newTask = Task(
                id: 0, // Assign 0 for now, as the backend will provide the actual ID
                title: titleController.text,
                description: descriptionController.text,
                completed: false, // New tasks are not completed by default
              );

              await Provider.of<TaskProvider>(context, listen: false).addTask(newTask);

              // Close the dialog
              Navigator.pop(context);
            },
            child: Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Task List'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _addTask,
          ),
        ],
      ),
      body: Consumer<TaskProvider>(
        builder: (context, taskProvider, _) => _isLoading
          ? CircularProgressIndicator()
          : taskProvider.tasks.isEmpty
            ? Center(child: Text('No tasks available.'))
            : ListView.builder(
                itemCount: taskProvider.tasks.length,
                itemBuilder: (context, index) {
                  final task = taskProvider.tasks[index];
                  return Dismissible(
                    key: Key(task.id.toString()),
                    onDismissed: (direction) {
                      // Delete the task
                      Provider.of<TaskProvider>(context, listen: false).deleteTask(task.id);
                    },
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: 20.0),
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                    child: ListTile(
                      title: Text(task.title),
                      subtitle: Text(task.description),
                      trailing: Checkbox(
                        value: task.completed,
                        onChanged: (value) {
                          taskProvider.updateTaskCompletion(task.id, value ?? false);
                        },
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
