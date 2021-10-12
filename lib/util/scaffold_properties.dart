import 'package:flutter/material.dart';

class ScaffoldProperties {
  bool resizeBottom;
  String title;

  ScaffoldProperties({this.resizeBottom = false, required this.title});

  ScaffoldProperties copyWith({ScaffoldProperties? state}) {
    return ScaffoldProperties(
      resizeBottom: state?.resizeBottom ?? resizeBottom,
      title: state?.title ?? title,
    );
  }
}
