import 'dart:async';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'market_time.dart';
import 'shared_variables.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ad_manager.dart';

class TradingPlan extends StatefulWidget {
  @override
  _TradingPlanState createState() => _TradingPlanState();
}

class _TradingPlanState extends State<TradingPlan> {
  final _formKey = GlobalKey<FormState>();
  int length = 29;
  String dropdownValue = 'NY';
  bool switch1 = false;
  bool switch2 = false;
  bool switch3 = false;
  bool switch4 = false;
  bool switch5 = false;
  bool switch6 = false;
  int _counter = 0;

  _saveData(
      String tradeRule1,
      String tradeRule2,
      String tradeRule3,
      String tradeRule4,
      String entryRule1,
      String entryRule2,
      String enterPair,
      String session) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('tradeRule1', tradeRule1);
    prefs.setString('tradeRule2', tradeRule2);
    prefs.setString('tradeRule3', tradeRule3);
    prefs.setString('tradeRule4', tradeRule4);
    prefs.setString('entryRule1', entryRule1);
    prefs.setString('entryRule2', entryRule2);
    prefs.setString('enterPair', enterPair);
    prefs.setString('session', session);
  }

  _removeData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('tradeRule1');
    prefs.remove('tradeRule2');
    prefs.remove('tradeRule3');
    prefs.remove('tradeRule4');
    prefs.remove('entryRule1');
    prefs.remove('entryRule2');
    prefs.remove('enterPair');
    prefs.remove('session');
  }

  _getData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      final tradeRule1 =
          prefs.getString('tradeRule1') ?? Variables.tradeRule1.text;
      final tradeRule2 =
          prefs.getString('tradeRule2') ?? Variables.tradeRule2.text;
      final tradeRule3 =
          prefs.getString('tradeRule3') ?? Variables.tradeRule3.text;
      final tradeRule4 =
          prefs.getString('tradeRule4') ?? Variables.tradeRule4.text;
      final entryRule1 =
          prefs.getString('entryRule1') ?? Variables.entryRule1.text;
      final entryRule2 =
          prefs.getString('entryRule2') ?? Variables.entryRule2.text;
      final enterPair =
          prefs.getString('enterPair') ?? Variables.enterPair.text;
      final session = prefs.getString('session') ?? dropdownValue;

      Variables.tradeRule1.text = tradeRule1;
      Variables.tradeRule2.text = tradeRule2;
      Variables.tradeRule3.text = tradeRule3;
      Variables.tradeRule4.text = tradeRule4;
      Variables.entryRule1.text = entryRule1;
      Variables.entryRule2.text = entryRule2;
      Variables.enterPair.text = enterPair;
      dropdownValue = session;
    });
  }

  String _timeString;
  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);

    setState(() {
      _timeString = formattedDateTime;
    });
  }

  String _formatDateTime(DateTime dateTime) {
    final String formattedDate = DateFormat('hh:mma').format(dateTime);
    // String ddate = DateFormat('a').format(dateTime);
    // if (ddate == 'AM') {
    //   ddate = 'PM';
    // } else {
    //   ddate = 'AM';
    // }
    // DateTime date = DateFormat.jm().parse(formattedDate + ' ' + ddate);
    // return DateFormat("HH:mm").format(date);
    return formattedDate;
  }

  int secondsPassed = 0;
  bool isActive = false;

  Timer timer;
  int seconds, minutes, hours;
  @override
  InterstitialAd _interstitialAd;
  bool _isInterstitialAdReady;
  void _loadInterstitialAd() {
    _interstitialAd.load();
  }

  void _onInterstitialAdEvent(MobileAdEvent event) {
    switch (event) {
      case MobileAdEvent.loaded:
        _isInterstitialAdReady = true;
        break;
      case MobileAdEvent.failedToLoad:
        _isInterstitialAdReady = false;
        print('Failed to load an interstitial ad');
        break;
      case MobileAdEvent.closed:
        _moveToHome();
        break;
      default:
      // do nothing
    }
  }

  BannerAd _bannerAd;
  void _loadBannerAd() {
    _bannerAd
      ..load()
      ..show(anchorType: AnchorType.top);
  }

  void initState() {
    _timeString = _formatDateTime(DateTime.now());
    _isInterstitialAdReady = false;

    _interstitialAd = InterstitialAd(
      adUnitId: AdManager.interstitialAdUnitId,
      listener: _onInterstitialAdEvent,
    );
    _bannerAd = BannerAd(
      adUnitId: AdManager.bannerAdUnitId,
      size: AdSize.banner,
    );
    Timer.periodic(Duration(minutes: 1), (Timer t) => _getTime());
    super.initState();
    _loadBannerAd();
    _removeData();
    _getData();
  }

  void dispose() {
    _interstitialAd.dispose();
    _bannerAd?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;

    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar:new AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Text('Homepage'),

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
                      fontSize: 20,
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
                      fontSize: 20,
                    ),
                  ),
                ),
                trailing: Icon(Icons.arrow_forward),
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MarketTime())),
              ),
            ],
          ),
        ),
        body: new Container(
          child: new FutureBuilder(
              future: _initAdMob(),
              builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                return Container(
                  child: SingleChildScrollView(
                    reverse: true,

                 child:   Padding(
padding: EdgeInsets.only(bottom: bottom),

                      child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                          Variables.firstColor,
                          Variables.secondColor,
                        ])),
                    child: Form(
                      key: _formKey,
                      child: Column(children: <Widget>[
                        //row 1
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                                flex: 2,
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      'Pair',
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                )),
                            Expanded(
                                flex: 5,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Padding(padding: EdgeInsets.only(top: 10)),
                                    Container(
                                      width: 140,
                                      height: 51,
                                      child: TextFormField(
                                        maxLength: 7,
                                        maxLengthEnforced: true,
                                        controller: Variables.enterPair,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.black),
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(50.0)),
                                              borderSide: BorderSide(
                                                color: Colors.transparent,
                                              )),
                                          hintStyle: TextStyle(
                                              color: Colors.black,
                                              fontFamily: "WorkSansLight"),
                                          filled: true,
                                          fillColor: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                            Expanded(
                                flex: 2,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Text(
                                      'Clock',
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                )),
                          ],
                        ),

                        //row 2
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Expanded(
                                flex: 3,
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Text(
                                          'Session',
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        )),
                                  ],
                                )),
                            Expanded(
                                flex: 3,
                                child: Column(
                                  children: <Widget>[
                                    DropdownButton<String>(
                                      value: dropdownValue,
                                      elevation: 16,
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                      ),
                                      onChanged: (String newValue) {
                                        setState(() {
                                          dropdownValue = newValue;
                                        });
                                      },
                                      items: <String>[
                                        'NY',
                                        'FrankFurt',
                                        'London',
                                        'Asia'
                                      ].map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value,
                                              textAlign: TextAlign.center),
                                        );
                                      }).toList(),
                                    ),
                                  ],
                                )),
                            Expanded(
                                flex: 4,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Container(
                                          height: 35,
                                          width: 100,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.white,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              _timeString,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )),
                                    ),
                                  ],
                                )),
                          ],
                        ),
                        Divider(
                          color: Colors.white,
                        ),
                        //row 3
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                    right: 40,
                                    bottom: 20,
                                  ),
                                  child: Text(
                                    'Trading plan rules',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 120,
                                    bottom: 20,
                                  ),
                                  child: Text(
                                    'No/Yes',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                                flex: 8,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 10,
                                        bottom: 10,
                                      ),
                                      child: TextFormField(
                                        maxLength: length,
                                        maxLengthEnforced: true,
                                        controller: Variables.tradeRule1,
                                        style: TextStyle(
                                            height: 0.5, color: Colors.black),
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20.0)),
                                              borderSide: BorderSide(
                                                color: Colors.transparent,
                                              )),
                                          hintStyle: TextStyle(
                                              color: Colors.black,
                                              fontFamily: "WorkSansLight"),
                                          filled: true,
                                          fillColor: Colors.white,
                                          // hintText: 'Enter  1st trade rule'
                                        ),

                                        // validator: (val) {
                                        //   if (val.isEmpty) {
                                        //     tradeRule1Error = true;
                                        //     tradeRule1ErrorText = 'please provide a value';
                                        //   }
                                        // },
                                      ),
                                    ),
                                  ],
                                )),
                            Expanded(
                                flex: 2,
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                        padding: const EdgeInsets.only(
                                          right: 10,
                                          bottom: 10,
                                        ),
                                        child: SizedBox(
                                          width: 75,
                                          height: 55,
                                          child: Switch(
                                            value: switch1,
                                            onChanged: (value) {
                                              setState(() {
                                                switch1 = value;
                                                if (switch1) {
                                                  _counter++;
                                                } else if (!switch1) {
                                                  _counter--;
                                                }
                                                print(switch1);
                                                print(_counter);
                                              });
                                            },
                                            inactiveTrackColor: Colors.red,
                                            activeTrackColor:
                                                Colors.lightGreenAccent,
                                            activeColor: Colors.green,
                                          ),
                                        ))
                                  ],
                                ))
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                                flex: 8,
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 10,
                                        bottom: 10,
                                      ),
                                      child: TextFormField(
                                        maxLength: length,
                                        maxLengthEnforced: true,
                                        controller: Variables.tradeRule2,
                                        validator: (val) {
                                          return val.isEmpty
                                              ? 'Please provide a Value'
                                              : null;
                                        },
                                        style: TextStyle(
                                            height: 0.5, color: Colors.black),
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20.0)),
                                              borderSide: BorderSide(
                                                color: Colors.transparent,
                                              )),
                                          hintStyle: TextStyle(
                                              color: Colors.black,
                                              fontFamily: "WorkSansLight"),
                                          filled: true,
                                          fillColor: Colors.white,
                                          //   hintText: 'Enter  2nd trade rule'
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                            Expanded(
                                flex: 2,
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                        padding: const EdgeInsets.only(
                                          right: 10,
                                          bottom: 10,
                                        ),
                                        child: SizedBox(
                                          width: 75,
                                          height: 55,
                                          child: Switch(
                                            value: switch2,
                                            onChanged: (value) {
                                              setState(() {
                                                switch2 = value;
                                                if (switch2) {
                                                  _counter++;
                                                } else if (!switch2) {
                                                  _counter--;
                                                }
                                                print(switch2);
                                                print(_counter);
                                              });
                                            },
                                            inactiveTrackColor: Colors.red,
                                            activeTrackColor:
                                                Colors.lightGreenAccent,
                                            activeColor: Colors.green,
                                          ),
                                        ))
                                  ],
                                ))
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                                flex: 8,
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 10,
                                        bottom: 10,
                                      ),
                                      child: TextFormField(
                                        maxLength: length,
                                        maxLengthEnforced: true,
                                        controller: Variables.tradeRule3,
                                        // validator: (val) {
                                        //   return val.isEmpty
                                        //       ? 'Please provide a Value'
                                        //       : null;
                                        // },
                                        style: TextStyle(
                                            height: 0.5, color: Colors.black),
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20.0)),
                                              borderSide: BorderSide(
                                                color: Colors.transparent,
                                              )),
                                          hintStyle: TextStyle(
                                              color: Colors.black,
                                              fontFamily: "WorkSansLight"),
                                          filled: true,
                                          fillColor: Colors.white,
                                          //  hintText: 'Enter  3rd trade rule'
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                            Expanded(
                                flex: 2,
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                        padding: const EdgeInsets.only(
                                          right: 10,
                                          bottom: 10,
                                        ),
                                        child: SizedBox(
                                          width: 75,
                                          height: 55,
                                          child: Switch(
                                            value: switch3,
                                            onChanged: (value) {
                                              setState(() {
                                                switch3 = value;
                                                if (switch3) {
                                                  _counter++;
                                                } else if (!switch3) {
                                                  _counter--;
                                                }
                                                print(switch3);
                                                print(_counter);
                                              });
                                            },
                                            inactiveTrackColor: Colors.red,
                                            activeTrackColor:
                                                Colors.lightGreenAccent,
                                            activeColor: Colors.green,
                                          ),
                                        ))
                                  ],
                                ))
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                                flex: 8,
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 10,
                                        bottom: 10,
                                      ),
                                      child: TextFormField(
                                        maxLength: length,
                                        maxLengthEnforced: true,
                                        controller: Variables.tradeRule4,
                                        // validator: (val) {
                                        //   return val.isEmpty
                                        //       ? 'Please provide a Value'
                                        //       : null;
                                        // },
                                        style: TextStyle(
                                            height: 0.5, color: Colors.black),
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20.0)),
                                              borderSide: BorderSide(
                                                color: Colors.transparent,
                                              )),
                                          hintStyle: TextStyle(
                                              color: Colors.black,
                                              fontFamily: "WorkSansLight"),
                                          filled: true,
                                          fillColor: Colors.white,
                                          //  hintText: 'Enter  4th trade rule'
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                            Expanded(
                                flex: 2,
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                        padding: const EdgeInsets.only(
                                          right: 10,
                                          bottom: 10,
                                        ),
                                        child: SizedBox(
                                          width: 75,
                                          height: 55,
                                          child: Switch(
                                            value: switch4,
                                            onChanged: (value) {
                                              setState(() {
                                                switch4 = value;
                                                if (switch4) {
                                                  _counter++;
                                                } else if (!switch4) {
                                                  _counter--;
                                                }
                                                print(switch4);
                                                print(_counter);
                                              });
                                            },
                                            inactiveTrackColor: Colors.red,
                                            activeTrackColor:
                                                Colors.lightGreenAccent,
                                            activeColor: Colors.green,
                                          ),
                                        ))
                                  ],
                                ))
                          ],
                        ),
                        Divider(
                          color: Colors.white,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 20,
                                bottom: 20,
                              ),
                              child: Text(
                                'Entry rules',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                                flex: 8,
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 10,
                                        bottom: 10,
                                      ),
                                      child: TextFormField(
                                        maxLength: length,
                                        maxLengthEnforced: true,
                                        controller: Variables.entryRule1,
                                        // validator: (val) {
                                        //   return val.isEmpty
                                        //       ? 'Please provide a Value'
                                        //       : null;
                                        // },
                                        style: TextStyle(
                                            height: 0.5, color: Colors.black),
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20.0)),
                                              borderSide: BorderSide(
                                                color: Colors.transparent,
                                              )),
                                          hintStyle: TextStyle(
                                              color: Colors.black,
                                              fontFamily: "WorkSansLight"),
                                          filled: true,
                                          fillColor: Colors.white,
                                          // hintText: 'Enter 1st rule'
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                            Expanded(
                                flex: 2,
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                        padding: const EdgeInsets.only(
                                          right: 10,
                                          bottom: 10,
                                        ),
                                        child: SizedBox(
                                          width: 75,
                                          height: 55,
                                          child: Switch(
                                            value: switch5,
                                            onChanged: (value) {
                                              setState(() {
                                                switch5 = value;
                                                if (switch5) {
                                                  _counter++;
                                                } else if (!switch5) {
                                                  _counter--;
                                                }
                                                print(switch5);
                                                print(_counter);
                                              });
                                            },
                                            inactiveTrackColor: Colors.red,
                                            activeTrackColor:
                                                Colors.lightGreenAccent,
                                            activeColor: Colors.green,
                                          ),
                                        ))
                                  ],
                                ))
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                                flex: 8,
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 10,
                                        bottom: 10,
                                      ),
                                      child: TextFormField(
                                        maxLength: length,
                                        maxLengthEnforced: true,
                                        controller: Variables.entryRule2,
                                        // validator: (val) {
                                        //   return val.isEmpty
                                        //       ? 'Please provide a Value'
                                        //       : null;
                                        //     },
                                        style: TextStyle(
                                            height: 0.5, color: Colors.black),
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20.0)),
                                              borderSide: BorderSide(
                                                color: Colors.transparent,
                                              )),
                                          hintStyle: TextStyle(
                                              color: Colors.black,
                                              fontFamily: "WorkSansLight"),
                                          filled: true,
                                          fillColor: Colors.white,
                                          //   hintText: 'Enter 2nd  rule'
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                            Expanded(
                                flex: 2,
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                        padding: const EdgeInsets.only(
                                          right: 10,
                                          bottom: 10,
                                        ),
                                        child: SizedBox(
                                          width: 75,
                                          height: 55,
                                          child: Switch(
                                            value: switch6,
                                            onChanged: (value) {
                                              setState(() {
                                                switch6 = value;
                                                if (switch6) {
                                                  _counter++;
                                                } else if (!switch6) {
                                                  _counter--;
                                                }
                                                print(switch6);
                                                print(_counter);
                                              });
                                            },
                                            inactiveTrackColor: Colors.red,
                                            //   inactiveColor: Colors.red,
                                            activeTrackColor:
                                                Colors.lightGreenAccent,
                                            activeColor: Colors.green,
                                          ),
                                        ))
                                  ],
                                ))
                          ],
                        ),
                        Divider(
                          color: Colors.white,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 20,
                                ),
                                child: Text(
                                  'Entry valid?',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ]),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: RaisedButton(
                            color: Colors.white,
                            onPressed: () => _getData(),
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0),
                            ),
                            child: (() {
                              if (_counter == 6) {
                                _loadInterstitialAd();
                                return Text(
                                  'Valid Trade',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                );
                              } else {
                                return Text(
                                  'Invalid Trade',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                  ),
                                );
                              }
                            }()),
                          ),
                        ),
                        //  ),
                        //      ],
                        //   ),

                        Padding(
                          padding: const EdgeInsets.only(
                            top: 15,
                            bottom: 20,
                          ),
                          child: ButtonTheme(
                            minWidth: 150.0,
                            height: 40.0,
                            child: RaisedButton(
                              color: Colors.orangeAccent,
                              shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0),
                              ),
                              onPressed: () {
                                if (_isInterstitialAdReady) {
                                  _interstitialAd.show();
                                }
                                _saveData(
                                    Variables.tradeRule1.text,
                                    Variables.tradeRule2.text,
                                    Variables.tradeRule3.text,
                                    Variables.tradeRule4.text,
                                    Variables.entryRule1.text,
                                    Variables.entryRule2.text,
                                    Variables.enterPair.text,
                                    dropdownValue);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MarketTime()));
                              },
                              child: const Text('Save',
                                  style: TextStyle(fontSize: 20)),
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ))),
                );
                //  ));
              }),
        ));
  }

  Future<void> _initAdMob() {
    return FirebaseAdMob.instance.initialize(appId: AdManager.appId);
  }

  void _moveToHome() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MarketTime()));
  }
}
