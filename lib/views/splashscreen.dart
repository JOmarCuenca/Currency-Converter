import 'package:currency_converter/controllers/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({ Key? key }) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  late SplashScreenController _controller;

  @override
  void initState() {
    this._controller = new SplashScreenController(context, this);
    this._controller.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitWanderingCubes(color: Theme.of(context).colorScheme.primary,),
    );
  }
}