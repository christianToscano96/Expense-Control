import 'package:flutter/material.dart';
//icons
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
//widget
import 'package:gastos/widgets/category_selection_widget.dart';

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
        _categorySelector(),
        _currentValue(),
        _numpad(),
        _submit(),
      ],
    );
  }

  Widget _categorySelector() {
    return Container(
      height: 80.0,
      child: CategorySelectionWidget(
        categories: {
          'Shopping'    : EvaIcons.shoppingCartOutline,
          'Alcohol'     : FontAwesomeIcons.beer,
          'Fast food'   : FontAwesomeIcons.hamburger,
          'Bills'       : EvaIcons.creditCardOutline,
          'Entreteiment': EvaIcons.headphonesOutline,
          'Services'    : EvaIcons.flashOutline

        },
      ),
    );
  }

  Widget _currentValue() => Placeholder(fallbackHeight: 120,);

  Widget _numpad() => Expanded(child: Placeholder());

  Widget _submit() => Placeholder(fallbackHeight: 50);
}