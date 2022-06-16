import 'package:flutter/material.dart';
import 'package:neryza_app_percent/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp2());
}

class MyApp2 extends StatelessWidget {
  const MyApp2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter DataBase',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const MyHomePage(title: 'Tips'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => State2();
}

class State2 extends State<MyHomePage> {
  final controllerPercent = TextEditingController();
  double tip = 0;

  void setDefaultValues(double value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('percent', value);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text(
          'DataBase Calculator',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.purple,
      ),
      body: Column(
        children: [
          const Text(''),
          const Text('Percent'),
          TextFormField(
            controller: controllerPercent,
            textAlign: TextAlign.center,
            decoration: const InputDecoration(hintText: '5%'),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
          const Text(''),
          ElevatedButton(
            onPressed: () {
              setState(() {
                double percent = double.parse(controllerPercent.text);
                setDefaultValues(percent);
              });
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyApp()),
              );
            },
            child: const Text('Set the percent'),
          )
        ],
      ),
    ));
  }
}
