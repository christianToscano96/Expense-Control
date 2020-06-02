import 'package:flutter/material.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class CategorySelectionWidget extends StatefulWidget {

  final Map<String, IconData> categories;

  const CategorySelectionWidget({Key key, this.categories}) : super(key: key);

  @override
  _CategorySelectionWidgetState createState() => _CategorySelectionWidgetState();
}

//catgories
class CategoryWidget extends StatelessWidget {
  final String name;
  final IconData icon;

  const CategoryWidget({Key key, this.name, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Container(
            height: 50.0,
            width: 50.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
              border: Border.all(
                color: Colors.purple,
              )
            ),
            child: Icon(icon, color: Colors.purple,),
          ),
        ),
        Text(name, style: TextStyle(height: 2.0),),
      ],
    );
  }
}


class _CategorySelectionWidgetState extends State<CategorySelectionWidget> {

  String currentItem = '';

  @override
  Widget build(BuildContext context) {

    var widgets = <Widget>[];

    widget.categories.forEach((name, icon) {
      widgets.add(
          CategoryWidget(
            name: name,
            icon: icon,  
          )
        );
    });

    return ListView(
      scrollDirection: Axis.horizontal,
      children: widgets,
    );
  }
}