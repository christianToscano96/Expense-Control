import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text('Category', style: TextStyle(color: Colors.black45),),
        actions: <Widget>[
          IconButton(
            icon: Icon(EvaIcons.closeOutline, color: Colors.black45,), 
            onPressed: () {
              Navigator.of(context).pop();
            }
          ),
        ],
        
      ),
      body: _body()
    );
  }

  //widget body
  Widget _body(){
    return Column(
      children: <Widget>[
        
      ],
    );
  };
}