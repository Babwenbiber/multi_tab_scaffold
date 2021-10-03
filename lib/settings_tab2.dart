import 'package:flutter/cupertino.dart';

class SettingsTab2 extends StatelessWidget {
  const SettingsTab2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
          onTap: () {
            Navigator.pop(
              context,
            );
          },
          child: const Text('Settings Tab 2')),
    );
  }
}