import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//pages
import 'package:gastos/graph.dart';

class MonthWidget extends StatefulWidget {

  final List<DocumentSnapshot> documents;
  final double total;
  final List<double> perDay;
  final Map<String, double> categories;

  MonthWidget({Key key, this.documents}) : 
        //get total
        total = documents.map((doc) => doc['value'])
          .fold(0.0, (a, b) => a + b),
        //get the days
        perDay = List.generate(30, (int index) {
          return documents.where((doc) => doc['day'] == (index + 1))
            .map((doc) => doc['value'])
            .fold(0.0, (a, b) => a + b);
        }),
        //get categories and total
        categories = documents.fold({}, (Map<String, double> map, document) {
          if(!map.containsKey(document['category'])){
            map[document['category']] = 0.0;
          }

          map[document['category']] += document['value'];
          return map;
        }),
        super(key: key);



  @override
  _MonthWidgetState createState() => _MonthWidgetState();
}

class _MonthWidgetState extends State<MonthWidget> {
  @override
  Widget build(BuildContext context) {
    print(widget.categories);
    return Expanded(
      child: Column(
       children: <Widget>[
         
          _expensas(),
          _grahp(),
          SizedBox(height: 15.0,),          
          _category(),
       ],
      ),
    );
  }

  //total expensas
    Widget _expensas() {
      return Column(
        children: <Widget>[
            Text("\$${widget.total.toStringAsFixed(2)}",
              style: TextStyle(fontSize: 40.6,
              fontWeight: FontWeight.bold,
              ),
            ),

          Text("Total expensas",
              style: TextStyle(fontWeight: FontWeight.bold,
              color: Colors.black38, fontSize: 16.0
            ),
          ),
        ],
      );
    }
    
    //graficos
    Widget _grahp() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        height: 250.0,
        child: GraphWidget(data: widget.perDay)
      );
    }

    //lista
    Widget _category() {
      return Expanded(
        child: ListView.separated(
          itemCount: widget.categories.keys.length,
          itemBuilder: (BuildContext context, int index ){ 
            //get categories and key
            var key  = widget.categories.keys.elementAt(index);
            var data = widget.categories[key];

            return _item(FontAwesomeIcons.shoppingCart, key, 100 * data  ~/ widget.total, data);
          },
          separatorBuilder: (BuildContext context, int index ) {
            return Container(
              color: Colors.black12,
              height: 2.0,
            );
          } ,
        ),
      );
    }

    //metodo para generar el layout de la listas
    Widget _item(IconData icon, String categoria, int porcentaje, double gasto) {
      
      return ListTile(
        leading: Icon(icon, color: Colors.purple, size: 32.0),
        title: Text(categoria, style: TextStyle( fontWeight: FontWeight.bold, fontSize: 20.0)),
        subtitle: Text('$porcentaje de las expensas',style: TextStyle(color: Colors.blueGrey, fontSize: 16.0)),
        trailing: Container(
          decoration:  BoxDecoration(
            color: Colors.purple.withOpacity(0.2),
            borderRadius: BorderRadius.circular(5.0)
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('\$$gasto',
            style: TextStyle(
                color: Colors.purple,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ),
        ),
      );
    }



   
}