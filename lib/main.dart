import 'package:flutter/material.dart';
import 'trading_plan.dart';
void main() {


var currentdate=DateTime.now();
var dentistAppointment = new DateTime(2017, 9, 7, 17, 30);
        // berlinWallFell.difference(dDay);

  var app=MaterialApp(
    home:Scaffold(
      body:Container(
        margin:EdgeInsets.all(50),
        child:Column(children: [
           Text("isAfter ${dentistAppointment.isAfter(currentdate)}") ,
                      Text("day Difference ${ currentdate.difference(dentistAppointment)}") ,

        ],)
        
        
      )
      
      
    )
  );

// runApp(app);
  runApp(MyApp());

  }

class MyApp extends StatelessWidget {
  // This widget is the root of  application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.blueGrey,
        // accentColor: Colors.cyan[600],
      ),
      home: MyHomePage(title: 'Trading Plan'),
    );
  }
} 

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  
  Widget build(BuildContext context) {
    return Scaffold(
      body: TradingPlan(),
    );
  }
}
