import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gallery/showImage.dart';

import 'package:http/http.dart' as http;

class GalleryList extends StatefulWidget {
  @override
  GalleryListState createState() => new GalleryListState();
}

class GalleryListState extends State<GalleryList> {
  int page = 1;
  List data = [];
  Future<String> makeRequest() async {
    var response = await http
        .get(Uri.encodeFull(getUrl()), headers: {"Accept": "application/json"});

    setState(() {
      var extractdata = json.decode(response.body);
      data.addAll(extractdata);
    });
  }

  String getUrl() {
    String url = 'https://api.unsplash.com/photos/?client_id=cf49c08b444ff4cb9e4d126b7e9f7513ba1ee58de7906e4360afc1a33d1bf4c0&page=$page';
    page += page;
    return url;
  }

  @override
  void initState() {
    this.makeRequest();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Gallery List'),
        ),
        body: new ListView.builder(
            itemCount: data.length,
            itemBuilder: (BuildContext context, i) {
              return new ListTile(
                title: new Text(
                  data[i]["description"] == null ? "unknown" : data[i]["description"],
                  maxLines: 1,
                ),
                subtitle: new Text(
                  data[i]["user"]["name"],
                  maxLines: 1,
                ),
                leading: new CircleAvatar(
                  backgroundImage:
                  new NetworkImage(data[i]["urls"]["small"]),
                ),

                onTap: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (BuildContext context) =>
                          new ShowImage(data[i])
                      )
                  );
                },
              );

            },

        ),
      resizeToAvoidBottomPadding: addImage(),
//      floatingActionButton: FloatingActionButton(
//        onPressed: _addItem,
//        child: Icon(Icons.add),
//      ),
    );
  }

  addImage() {
    setState(() {
      this.makeRequest();
    });
  }
}

