import 'package:flutter/cupertino.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({Key? key}) : super(key: key);
  static const routeName = "/home_tab";

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Home Tab'),
    );
  }
}
