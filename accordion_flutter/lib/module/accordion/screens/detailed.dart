import 'package:accordionflutter/module/accordion/model/ampGenericObject.dart';
import 'package:flutter/material.dart';

class DetailedScreen extends StatelessWidget {
  AMPGenericObject object;

  DetailedScreen({@required this.object});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
      ),
      body: Center(
        child: Text(object.name),
      ),
    );
  }
}
