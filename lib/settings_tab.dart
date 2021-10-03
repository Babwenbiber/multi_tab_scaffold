import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  int counter = 0;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, "/settings2");
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MaterialButton(
                onPressed: () => setState(() => counter++),
                child: const Text("click me to increase the counter"),
              ),
              Text(
                "counter is $counter",
              ),
              const Text('get deeper Settings Tab'),
            ],
          )),
    );
  }
}