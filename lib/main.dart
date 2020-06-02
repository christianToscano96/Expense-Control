
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//iconos 
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//pages
import 'package:gastos/grafico.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestion Gastos',
      theme: ThemeData(
        
        primarySwatch: Colors.pink,
                         
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home:HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {

  //conroller para maejar el scroll view de los meses
  PageController _controller;
  int pageInitial = 9;

  @override
  void initState(){
    super.initState();

    _controller = PageController(
      initialPage: pageInitial,
      viewportFraction: 0.4,
    );
  }

  @override 
    Widget build(BuildContext context) {
      return Scaffold(

        body: _body(),
        
        bottomNavigationBar: _botonera(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),  
          onPressed: () {},
        ),
      );
    }


    //secciones del body
    Widget _body() {
      return SafeArea(
        child: Column(
          children: <Widget>[
            _selector(), 
            _expensas(),
            _graficos(),
            SizedBox(height: 15.0,),          
            _lista(),
          ],
        ),
      );
    }

    //Widgets de areas
    Widget _selector(){
      return SizedBox.fromSize(
        size: Size.fromHeight(70.0),
        child: PageView(
          controller: _controller,
          onPageChanged: (newPage) {
            setState(() {
              pageInitial = newPage;
            });
          },
        children: <Widget>[
          _pageItems('Enero',0),
          _pageItems('Febrero',1),
          _pageItems('Marzo',2),
          _pageItems('Abril',3),
          _pageItems('Mayo',4),
          _pageItems('Junio',5),
          _pageItems('Julio',6),
          _pageItems('Agosto',7),
          _pageItems('Septiembre',8),
          _pageItems('Octubre',9),
          _pageItems('Noviembre',10),
          _pageItems('Diciembre',11),
          
        ],
      )
      );
    }
    //para centrar el mes seleccionado
    Widget _pageItems(String name, int position){
      var _alignment;
      final selected = TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        color: Colors.pinkAccent
      );
      final unselected = TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.normal,
        color: Colors.pinkAccent.withOpacity(0.4),
      );

      if(position == pageInitial){
        _alignment = Alignment.center;
      } else if(position > pageInitial) {
        _alignment = Alignment.centerRight;
      }else{
        _alignment = Alignment.centerLeft;
      }

      return Align(
        alignment: _alignment,
        child: Text(name,
          style: position == pageInitial ? selected : unselected,
        )
      );
    }

    
    //total expensas
    Widget _expensas() {
      return Column(
        children: <Widget>[
            Text("\$ 2300.55",
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
    Widget _graficos() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        height: 250.0,
        child: GraphWidget()
      );
    }

    //lista
    Widget _lista() {
      return Expanded(
        child: ListView.separated(
          itemCount: 15,
          itemBuilder: (BuildContext context, int index ) =>_item(FontAwesomeIcons.shoppingCart, 'Mercaderia', 14, 142.50),        
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
        leading: Icon(icon, color: Colors.pinkAccent.withOpacity(0.5), size: 32.0),
        title: Text(categoria, style: TextStyle( fontWeight: FontWeight.bold, fontSize: 20.0)),
        subtitle: Text('$porcentaje de las expensas',style: TextStyle(color: Colors.blueGrey, fontSize: 16.0)),
        trailing: Container(
          decoration:  BoxDecoration(
            color: Colors.pink.withOpacity(0.2),
            borderRadius: BorderRadius.circular(5.0)
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('\$$gasto',
            style: TextStyle(
                color: Colors.pinkAccent,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ),
        ),
      );
    }



    //widget de botonera 
    Widget _botonera() {
      return BottomAppBar(
          notchMargin: 8.0,
          shape: CircularNotchedRectangle(),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _bottomAction(FontAwesomeIcons.history),
              _bottomAction(FontAwesomeIcons.chartPie),
              SizedBox(width: 48.0),
              _bottomAction(FontAwesomeIcons.wallet),
              _bottomAction(Icons.settings),
            ],
          ),
        );
    }
    //widget de iconos
    Widget _bottomAction(IconData icon) {
      return InkWell(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Icon(icon),
        ),
        onTap: (){},
      );
    }
}