
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//iconos 
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
//pages
import 'package:gastos/month_widget.dart';



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
        
        primarySwatch: Colors.purple,
                         
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
  int currentPage = 9;
  //firebase variable
  Stream<QuerySnapshot> _query;

  @override
  void initState(){
    super.initState();

    //firebase 
    _query = Firestore.instance
              .collection('expenses')
              .where("month", isEqualTo: currentPage + 1)
              .snapshots();
              

    _controller = PageController(
      initialPage: currentPage,
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
          child: Icon(EvaIcons.plusOutline),  
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
            StreamBuilder<QuerySnapshot>(
              stream: _query,
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> data){
                if(data.hasData){
                  return MonthWidget(
                    documents: data.data.documents,
                  );
                }else{
                  return Center(                   
                    child: CircularProgressIndicator(),
                  );
                }
                
              }
            ),
          ],
        ),
      );
    }

    //Widgets de meses
    Widget _selector(){
      return SizedBox.fromSize(
        size: Size.fromHeight(70.0),
        child: PageView(
          controller: _controller,
          onPageChanged: (newPage) {
            setState(() {
              currentPage = newPage;
              //atar al cambio de pagina
              _query = Firestore.instance
                  .collection('expenses')
                  .where("month", isEqualTo: currentPage + 1)
                  .snapshots();
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
        color: Colors.purple
      );
      final unselected = TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.normal,
        color: Colors.purple.withOpacity(0.4),
      );

      if(position == currentPage){
        _alignment = Alignment.center;
      } else if(position > currentPage) {
        _alignment = Alignment.centerRight;
      }else{
        _alignment = Alignment.centerLeft;
      }

      return Align(
        alignment: _alignment,
        child: Text(name,
          style: position == currentPage ? selected : unselected,
        )
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
              _bottomAction(EvaIcons.trendingUpOutline),
              _bottomAction(EvaIcons.pieChartOutline),
              SizedBox(width: 48.0),
              _bottomAction(EvaIcons.shoppingBagOutline),
              _bottomAction(EvaIcons.settings2Outline),
            ],
          ),
        );
    }
    //widget de iconos
    Widget _bottomAction(IconData icon) {
      return InkWell(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Icon(icon,size: 25.0,),
        ),
        onTap: (){},
      );
    }
    
    
}