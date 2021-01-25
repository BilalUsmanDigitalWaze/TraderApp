import 'dart:async';

import 'package:flutter/material.dart';
import 'shared_variables.dart';
import 'trading_plan.dart';
import 'package:intl/intl.dart';
import 'hoidays.dart';
import 'package:flutter/services.dart';

class MarketTime extends StatefulWidget {
  @override
  _MarketTimeState createState() => _MarketTimeState();
}

class _MarketTimeState extends State<MarketTime> {
   String londonTime =Variables.getTime(
                            Variables.londonopen, Variables.londonclose
                            );
String asiaFxTime =Variables.getTime(
                            Variables.asiaFxopen, Variables.asiaFxclose
                            );
String frankfurtTime =Variables.getTime(
                            Variables.frankfurtopen, Variables.frankfurtclose
                            );
String asiaStockTime =Variables.getTime(
                            Variables.asiaStockopen, Variables.asiaStockclose
                            );
String nyStockTime =Variables.getTime(
                            Variables.nyStockopen, Variables.nyStockclose
                            );
                            String nyFxTime =Variables.getTime(
                            Variables.nyFxopen, Variables.nyFxclose
                            );
    int _counter = 10;

  Timer _timer;

  void _startTimer() {
    _counter = 10;
    if (_timer != null) {
      _timer.cancel();
    }
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_counter > 0) {
londonTime= Variables.getTime(
                            Variables.londonopen, Variables.londonclose
                            );

 asiaFxTime =Variables.getTime(
                            Variables.asiaFxopen, Variables.asiaFxclose
                            );
asiaFxTime =Variables.getTime(
                            Variables.asiaFxopen, Variables.asiaFxclose
                            );
 frankfurtTime =Variables.getTime(
                            Variables.frankfurtopen, Variables.frankfurtclose
                            );
nyFxTime =Variables.getTime(
                            Variables.nyFxopen, Variables.nyFxclose
                            );
 asiaStockTime =Variables.getTime(
                            Variables.asiaStockopen, Variables.asiaStockclose
                            );
 nyStockTime =Variables.getTime(
                            Variables.nyStockopen, Variables.nyStockclose
                            );

        } else {
          _timer.cancel();
        }
      });
    });
  }
  static final DateTime now = DateTime.now();
  static final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final String formatted = formatter.format(now);

  void initState() {
    super.initState();
    print(formatted);
    _startTimer();

  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar:new AppBar(
          
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Text('Market sessions'),

        ),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    "Trading plan",
                    style: TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Divider(color: Colors.black),
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    "Homepage",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
                trailing: Icon(Icons.arrow_forward),
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TradingPlan())),
              ),
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    "Market sessions",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
                trailing: Icon(Icons.arrow_forward),
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MarketTime())),
              ),
              // ListTile(
              //   title: Padding(
              //     padding: const EdgeInsets.all(12.0),
              //     child: Text(
              //       "Trade journal",
              //       style: TextStyle(
              //         fontSize: 20,
              //       ),
              //     ),
              //   ),
              //   trailing: Icon(Icons.arrow_forward),
              //   onTap: () => Navigator.push(context,
              //       MaterialPageRoute(builder: (context) => TradeJournal())),
              // ),

              // ListTile(
              //   title: Padding(
              //     padding: const EdgeInsets.all(12.0),
              //     child: Text(
              //       "Save journal",
              //       style: TextStyle(
              //         fontSize: 20,
              //       ),
              //     ),
              //   ),
              //   trailing: Icon(Icons.arrow_forward),
              //   onTap: () => Navigator.push(context,
              //       MaterialPageRoute(builder: (context) => ViewJournal())),
              // ),
            ],
          ),
        ),
        body: Center(
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                  Variables.firstColor,
                  Variables.secondColor,
                ])),
            child: Column(children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(padding: EdgeInsets.only(top: 30)),
                  Text(
                    'Markets',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  Text(
                    'Open Time',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  Text(
                    'Close Time',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
              Divider(),
              IntrinsicHeight(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                        'London',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      VerticalDivider(
                        color: Colors.white,
                      ),
                      Text(
                        '${Variables.londonopen} hours ',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.green[900],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      VerticalDivider(
                        color: Colors.white,
                      ),
                      Text(
                        '${Variables.londonclose} hours',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ]),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(top: 50)),
                  Text(
                    (formatted == Holidays.goodfir) ||
                            (formatted == Holidays.eastmon) ||
                            (formatted == Holidays.earlymhd1) ||
                            (formatted == Holidays.latembh) ||
                            (formatted == Holidays.summerbh) ||
                            (formatted == Holidays.chris) ||
                            (formatted == Holidays.boxday) ||
                            (formatted == Holidays.newyears)
                        ? 'Market sessions are close on $formatted'
                        : londonTime ,
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
              Divider(
                color: Colors.white,
              ),
              IntrinsicHeight(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                        'FrankFurt',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      VerticalDivider(
                        color: Colors.white,
                      ),
                      Text(
                        '${Variables.frankfurtopen} hours',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.green[900],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      VerticalDivider(
                        color: Colors.white,
                      ),
                      Text(
                        '${Variables.frankfurtclose} hours',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ]),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(top: 50)),
                  Text(
                    (formatted == Holidays.labday) ||
                            (formatted == Holidays.whitmon) ||
                            (formatted == Holidays.chriseve) ||
                            (formatted == Holidays.newyears) ||
                            (formatted == Holidays.goodfir) ||
                            (formatted == Holidays.eastmon) ||
                            (formatted == Holidays.chris) ||
                            (formatted == Holidays.newyeareve)
                        ? 'Marte sessions are close on $formatted'
                        : frankfurtTime,
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
              Divider(
                color: Colors.white,
              ),
              IntrinsicHeight(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                        'Asia FX',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      VerticalDivider(
                        color: Colors.white,
                      ),
                      Text(
                        '${Variables.asiaFxopen} hours',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.green[900],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      VerticalDivider(
                        color: Colors.white,
                      ),
                      Text(
                        '${Variables.asiaFxclose} hours',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ]),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(top: 50)),
                  Text(
                    (formatted == Holidays.newyears) ||
                            (formatted == Holidays.bankholiday2) ||
                            (formatted == Holidays.bankholiday3) ||
                            (formatted == Holidays.adulltsday) ||
                            (formatted == Holidays.nationalfoundation) ||
                            (formatted == Holidays.obs) ||
                            (formatted == Holidays.vernal) ||
                            (formatted == Holidays.showaday) ||
                            (formatted == Holidays.gday) ||
                            (formatted == Holidays.cday) ||
                            (formatted == Holidays.cdayobs) ||
                            (formatted == Holidays.mday) ||
                            (formatted == Holidays.hsday) ||
                            (formatted == Holidays.mountday) ||
                            (formatted == Holidays.respday) ||
                            (formatted == Holidays.ae) ||
                            (formatted == Holidays.cultday) ||
                            (formatted == Holidays.labthanksday) ||
                            (formatted == Holidays.newyeareve)
                        ? 'Market sessions are close on $formatted'
                      
                        : asiaFxTime,
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
              Divider(
                color: Colors.white,
              ),
              IntrinsicHeight(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                        'Asia Stock',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      VerticalDivider(
                        color: Colors.white,
                      ),
                      Text(
                        '${Variables.asiaStockopen} hours',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.green[900],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      VerticalDivider(
                        color: Colors.white,
                      ),
                      Text(
                        '${Variables.asiaStockclose} hours',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ]),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(top: 50)),
                  Text(
                    (formatted == Holidays.newyears) ||
                            (formatted == Holidays.bankholiday2) ||
                            (formatted == Holidays.bankholiday3) ||
                            (formatted == Holidays.adulltsday) ||
                            (formatted == Holidays.nationalfoundation) ||
                            (formatted == Holidays.obs) ||
                            (formatted == Holidays.vernal) ||
                            (formatted == Holidays.showaday) ||
                            (formatted == Holidays.gday) ||
                            (formatted == Holidays.cday) ||
                            (formatted == Holidays.cdayobs) ||
                            (formatted == Holidays.mday) ||
                            (formatted == Holidays.hsday) ||
                            (formatted == Holidays.mountday) ||
                            (formatted == Holidays.respday) ||
                            (formatted == Holidays.ae) ||
                            (formatted == Holidays.cultday) ||
                            (formatted == Holidays.labthanksday) ||
                            (formatted == Holidays.newyeareve)
                        ? 'Market sessions are close on $formatted'
                        :asiaStockTime,
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
              Divider(
                color: Colors.white,
              ),
              IntrinsicHeight(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                        'NY FX',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      VerticalDivider(
                        color: Colors.white,
                      ),
                      Text(
                        '${Variables.nyFxopen} hours',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.green[900],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      VerticalDivider(
                        color: Colors.white,
                      ),
                      Text(
                        '${Variables.nyFxclose} hours',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ]),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(top: 50)),
                  Text(
                    (formatted == Holidays.martinday) ||
                            (formatted == Holidays.presday) ||
                            (formatted == Holidays.memday) ||
                            (formatted == Holidays.indedayobs) ||
                            (formatted == Holidays.thanks) ||
                            (formatted == Holidays.newyears) ||
                            (formatted == Holidays.goodfir) ||
                            (formatted == Holidays.labday) ||
                            (formatted == Holidays.chris)
                        ? 'Market sessions are close on $formatted'
                        : nyFxTime,
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
              Divider(
                color: Colors.white,
              ),
              IntrinsicHeight(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                        'NY Stock',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      VerticalDivider(
                        color: Colors.white,
                      ),
                      Text(
                        '${Variables.nyStockopen} hours',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.green[900],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      VerticalDivider(
                        color: Colors.white,
                      ),
                      Text(
                        '${Variables.nyStockclose} hours',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ]),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(top: 50)),
                  Text(
                    (formatted == Holidays.martinday) ||
                            (formatted == Holidays.presday) ||
                            (formatted == Holidays.memday) ||
                            (formatted == Holidays.indedayobs) ||
                            (formatted == Holidays.thanks) ||
                            (formatted == Holidays.newyears) ||
                            (formatted == Holidays.goodfir) ||
                            (formatted == Holidays.labday) ||
                            (formatted == Holidays.chris)
                        ? 'Market sessions are close on $formatted'
                        : nyStockTime,
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
              Divider(
                color: Colors.white,
              ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: ButtonTheme(
              //     minWidth: 120,
              //     height: 40,
              //     child: RaisedButton(
              //         color: Colors.white,
              //         shape: new RoundedRectangleBorder(
              //           borderRadius: new BorderRadius.circular(30.0),
              //         ),
              //         child: Text(
              //           'Next',
              //           style: TextStyle(
              //             fontSize: 20,
              //           ),
              //         ),
              //         onPressed: () {
              //           Navigator.push(
              //             context,
              //             MaterialPageRoute(
              //                 builder: (context) => TradeJournal()),
              //           );
              //         }),
              //   ),
              // )
            ]),
          ),
        ));
  }
}
