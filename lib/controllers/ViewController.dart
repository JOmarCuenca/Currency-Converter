import 'package:flutter/material.dart';

abstract class ViewController {
  BuildContext _context;
  State _view;

  ViewController(this._context,this._view);

  Future<void> init();

  /// General context of the Widget
  BuildContext get context => this._context;

  /// State of the Widget
  State get view => this._view;

  /// Update the view of the component
  // ignore: invalid_use_of_protected_member
  void updateState() => this._view.setState(() {});
}