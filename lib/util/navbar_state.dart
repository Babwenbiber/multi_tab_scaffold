import 'package:flutter/material.dart';

class NavbarState {
  bool resizeBottom;
  String title;

  NavbarState({this.resizeBottom = false, required this.title});

  NavbarState copyWith({NavbarState? state}) {
    return NavbarState(
      resizeBottom: state?.resizeBottom ?? resizeBottom,
      title: state?.title ?? title,
    );
  }
}
