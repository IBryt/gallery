import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gallery/showImage.dart';
import 'package:sprintf/sprintf.dart';

import 'package:http/http.dart' as http;

class GalleryList extends StatefulWidget {
  @override
  _GalleryListState createState() => new _GalleryListState();
}

class _GalleryListState extends State<GalleryList> {
  static const String _URL =
      'https://api.unsplash.com/photos/?client_id=%s&page=%s';
  static const String _CLIENT =
      'cf49c08b444ff4cb9e4d126b7e9f7513ba1ee58de7906e4360afc1a33d1bf4c0';
  int _page = 1;
  List _data = [];

  Future<http.Response> _makeRequest() async {
    var response = await http.get(
        sprintf(_URL, [_CLIENT, _page++]),
        headers: {"Accept": "application/json"});
    setState(() =>
      this._data.addAll(json.decode(response.body)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text('Gallery List'),
      ),
      body: _buildGalleryList(),
    );
  }

  Widget _buildGalleryList()  {
    return ListView.builder(
        itemBuilder: (context, i) {
          if (i >= _data.length) {
            _makeRequest();
          }
          return _buildRow(i);
        });
  }

  Widget _buildRow(int i) {
    if (i < _data.length) {
      return new ListTile(
        title: new Text(_data[i]["description"] ?? "unknown", maxLines: 1),
        subtitle: new Text(_data[i]["user"]["name"], maxLines: 1),
        leading: new CircleAvatar(
          backgroundImage:
          new NetworkImage(_data[i]["urls"]["small"]),
        ),
        onTap: () {
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (BuildContext context) =>
                  new ShowImage(_data[i]))
          );
        },
      );
    }
  }
}
