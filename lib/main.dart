import 'package:flutter/material.dart';
import 'package:neryza_app_percent/database.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final controllerAmount = TextEditingController();
  final controllerPercent = TextEditingController();
  double tip = 0;

  Future<double?> getDefaultValues() async {
    final prefs = await SharedPreferences.getInstance();
    final double percent = prefs.getDouble('percent') ?? 15;
    return percent;
  }

  @override
  Widget build(BuildContext context) {
    State2 per = State2();
    getDefaultValues()
        .then((value) => {controllerPercent.text = value.toString()});

    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tip Calculator',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.purple,
      ),
      body: Column(
        children: [
          const Text(''),
          const Text('Amount'),
          TextFormField(
            controller: controllerAmount,
            textAlign: TextAlign.center,
            decoration: const InputDecoration(hintText: '\$50.00'),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
          const Text(''),
          const Text('Percent'),
          TextFormField(
            controller: controllerPercent,
            textAlign: TextAlign.center,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
          const Text(''),
          Text('Tip to Pay \$$tip'),
          const Text(''),
          ElevatedButton(
            onPressed: () {
              setState(() {
                double amount = double.parse(controllerAmount.text);
                double percent = double.parse(controllerPercent.text);
                tip = amount * percent / 100;
                per.setDefaultValues(percent);
              });
            },
            child: Text("Calculate Tip"),
          )
        ],
      ),
    ));
  }
}
