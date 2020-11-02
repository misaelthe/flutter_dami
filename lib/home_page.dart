import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: new Text("Home"),
      ),
      body: Center(
        child: new Text("Home Page"),
      ),
    );
  }
}
