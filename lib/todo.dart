import 'package:flutter/material.dart';

class TodoApp extends StatefulWidget {
  const TodoApp({Key? key}) : super(key: key);

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  //! List of todo items
  final List _todoItems = [];
  //! controller to help track changes in text field
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

  //! Function that clears all TODO items
  deleteAll() {
    setState(() {
      _todoItems.clear();
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
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  FlutterLogo(
                    size: 40,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "TODOs",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 400,
              child: ListView.builder(
                itemCount: _todoItems.length,
                itemBuilder: (context, index) => Card(
                  child: ListTile(
                    tileColor: Colors.white10,
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
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 200),
                                  // color: Colors.white,
                                  height:
                                      MediaQuery.of(context).size.height / 3,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        "Are you Sure you want to delete?",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w300,
                                            fontFamily: 'Roboto',
                                            letterSpacing: 0.3,
                                            color: Colors.white),
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            elevation: 20),
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
            const Align(
              child: SizedBox(
                height: 180,
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => Container(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            margin: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 200),
                            // color: Colors.white,
                            height: MediaQuery.of(context).size.height / 3,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Are you sure you want to clear all TODOs?",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w300,
                                      fontFamily: 'Roboto',
                                      letterSpacing: 0.3,
                                      color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          elevation: 20),
                                      onPressed: () {
                                        deleteAll();
                                        Navigator.pop(context);
                                      },
                                      child: const Text("Yes"),
                                    ),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            elevation: 20),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text("No")),
                                  ],
                                ),
                              ],
                            ),
                          ));
                },
                child: const Text("Clear"))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          // backgroundColor: Colors.indigo,
          onPressed: () {
            showModalBottomSheet(
                context: context,
                builder: (context) => Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: Column(
                        children: [
                          TextField(
                            controller: textController,
                            // onChanged: (value) {
                            //   print(value);
                            //   print(textController.text);
                            // },
                            decoration: const InputDecoration(
                                label: Text("Enter TODO item"),
                                labelStyle: TextStyle(fontSize: 18)),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(elevation: 20),
                            onPressed: () {
                              addTodo(textController.text);
                              textController.clear();
                              Navigator.pop(context);
                            },
                            child: const Text("Add TODO"),
                          )
                        ],
                      ),
                    ));
          },
          child: const Icon(Icons.add),
        ));
  }
}
