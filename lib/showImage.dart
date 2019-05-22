
import 'package:flutter/material.dart';

class ShowImage extends StatelessWidget {
  ShowImage(this.data);
  final data;
  @override
  Widget build(BuildContext context) => new Scaffold(
      appBar: new AppBar(title: new Text('Second Page')),
      body: new Center(
        child: new Container(
          decoration: new BoxDecoration(
            color: Colors.white,
            image: new DecorationImage(
                image: new NetworkImage(data["urls"]["full"]),
                fit: BoxFit.contain
            ),
          ),
        ),
      ));
}
