import 'dart:async';

import 'package:currency_converter/controllers/ViewController.dart';
import 'package:currency_converter/services/API.dart';
import 'package:currency_converter/services/DatabaseService.dart';
import 'package:currency_converter/views/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SplashScreenController extends ViewController {

  static const WAIT_TIME = 1.5 * 1000;

  SplashScreenController(BuildContext context, State view) : super(context, view);

  void _pushNext(){
    Navigator.of(this.context).pushReplacement(MaterialPageRoute(builder: (c) => HomeView()));
  }

  @override
  Future<void> init() async {
    final initTime = DateTime.now();
    await Future.wait([
      APIService().readyService,
      DatabaseService().readyService
    ]);
    final stopTime = DateTime.now();
    final dif = stopTime.difference(initTime);
    if(dif.inMilliseconds < WAIT_TIME)
      Timer(dif, () => this._pushNext());
    else
      this._pushNext();
  }
}