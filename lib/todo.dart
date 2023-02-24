import 'package:flutter/material.dart';

class TodoApp extends StatefulWidget {
  const TodoApp({Key? key}) : super(key: key);

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  //! List of todo items
  final List _todoItems = [];
  //! controller to help track changes in textfield
  final textController = TextEditingController();

  //! Function to add todo item
  addTodo(String todoItem) {
    if (todoItem.isNotEmpty) {
      setState(() {
        _todoItems.add(todoItem);
      });
    }
  }

  //! Function to delete todo item
  deleteTodo(int index) {
    setState(() {
      _todoItems.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "My Schedule",
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              SizedBox(
                height: 200,
                child: ListView.builder(
                  itemCount: _todoItems.length,
                  itemBuilder: (context, index) => Card(
                    child: ListTile(
                      title: GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) => Container(
                                padding: const EdgeInsets.all(24),
                                child: Text(
                                  _todoItems[index],
                                ),
                              ),
                            );
                          },
                          child: Text(_todoItems[index])),
                      trailing: IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) => Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 24, vertical: 50),
                                    color: Colors.white,
                                    height:
                                        MediaQuery.of(context).size.height / 3,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Text(
                                            "Are you Sure you want to delete?"),
                                        ElevatedButton(
                                          onPressed: () {
                                            deleteTodo(index);
                                            Navigator.pop(context);
                                          },
                                          child: const Text("Delete Todo"),
                                        ),
                                      ],
                                    ),
                                  ));
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          // backgroundColor: Colors.indigo,
          onPressed: () {},
          child: const Icon(Icons.add, color: Colors.white),
        ));
  }
}
