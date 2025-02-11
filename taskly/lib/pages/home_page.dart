import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage();

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  late double _deviceHeight, _deviceWidth;

  _HomePageState();

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        toolbarHeight: _deviceHeight * 0.15,
        title: const Text(
          "Taskly!",
          style: TextStyle(
            fontSize: 25,
            color: Colors.white,
          ),
        ),
      ),
      body: _taskList(),
      floatingActionButton: _addTaskButton(),
    );
  }
}



Widget _taskList() {
  return ListView(
    children: [
      ListTile(
        title: Text(
          "Learn Flutter",
          style: TextStyle(decoration: TextDecoration.lineThrough),
        ),
        subtitle: Text(DateTime.now().toString()),
        trailing: Icon(
          Icons.check_box_outlined,
          color: Colors.red,
        ),
      ),
      ListTile(
        title: Text(
          "Learn Flutter",
          style: TextStyle(decoration: TextDecoration.lineThrough),
        ),
        subtitle: Text(DateTime.now().toString()),
        trailing: Icon(
          Icons.check_box_outlined,
          color: Colors.red,
        ),
      ),
      ListTile(
        title: Text(
          "Learn Flutter",
          style: TextStyle(decoration: TextDecoration.lineThrough),
        ),
        subtitle: Text(DateTime.now().toString()),
        trailing: Icon(
          Icons.check_box_outlined,
          color: Colors.red,
        ),
      ),
    ],
  );
}

Widget _addTaskButton() {
  return FloatingActionButton(
    onPressed: () {
      print("Pressed");
    },
    child: Icon(Icons.add),
  );
}
