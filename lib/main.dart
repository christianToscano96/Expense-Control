
import 'package:flutter/material.dart';

//pages
import 'package:gastos/pages/home_page.dart';
import 'package:gastos/pages/add_page.dart';



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
      debugShowCheckedModeBanner: false,
      //home:HomePage(),
      routes: {
        '/'    : (BuildContext context) => HomePage(),
        '/add' : (BuildContext context) => AddPage(),
      },
    );
  }
}

