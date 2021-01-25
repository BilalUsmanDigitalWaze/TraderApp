import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './timeZoneHelper.dart';

class Variables {
  static String frankfurtopen = '08:00:00 ';
  static String frankfurtclose = '17:00:00 ';

  static String londonopen = '09:00:00 ';
  static String londonclose = '17:00:00';

  static String asiaFxopen = '02:00:00 ';
  static String asiaFxclose = '11:00:00 ';

  static String asiaStockopen = '03:00:00 ';
  static String asiaStockclose = '11:00:00 ';

  static String nyFxopen = '14:00:00 ';
  static String nyFxclose = '23:00:00 ';

  static String nyStockopen = '15:30:00 ';
  static String nyStockclose = '22:00:00 ';

  static String getTime(String startTime, closeTime) {
var data=new TimeHelperService();
data.convertLocalToDetroit();
    print("start Time $startTime endTime $closeTime");
    var day = DateFormat('EEEE').format(DateTime.now());
        print("day $day");

//    var day = 'Saturday';
    var format = DateFormat("HH:mm:ss");
    var open = format.parse(startTime);
    var close = format.parse(closeTime);
    print("start Time $open endTime $close");

    var now = new DateTime.now();
    var time = format.format(now);
    var timeCurrent = format.parse(time);
    print('time Current ${timeCurrent.isAfter(close)}');
    print(day);
    if (day == 'Saturday' || day == 'Sunday') {
      return 'Market sessions are closed';
    } else {
      if (timeCurrent.isAfter(close) &&
          timeCurrent.isAfter(open) &&
          day == 'Friday') {
        return 'Market sessions are closed';
      } else if (timeCurrent.isBefore(open) &&
          timeCurrent.isBefore(close) &&
          day == 'Friday') {
        return 'Market sessions are closed';
      } else if (timeCurrent.isAfter(open) && timeCurrent.isBefore(close)) {
        var formatDate = format.parse(close.difference(timeCurrent).toString());
        String formattedDate = DateFormat('HH : mm :ss').format(formatDate);
        return 'Market session will close in $formattedDate';
      } else if (timeCurrent.isAfter(close) && timeCurrent.isAfter(open)) {
        var formatDate = format.parse(timeCurrent.difference(open).toString());
        String formattedDate = DateFormat('HH : mm :ss').format(formatDate);
        return 'Market session will open in $formattedDate';
      } else if (timeCurrent.isBefore(open) && timeCurrent.isBefore(close)) {
        var formatDate = format.parse(open.difference(timeCurrent).toString());
        String formattedDate = DateFormat('HH : mm :ss').format(formatDate);
        return 'Market session will open in $formattedDate ';
      }
    }
  }

  static TextEditingController tradeRule1 = new TextEditingController();
  static TextEditingController tradeRule2 = new TextEditingController();
  static TextEditingController tradeRule3 = new TextEditingController();
  static TextEditingController tradeRule4 = new TextEditingController();
  static TextEditingController entryRule1 = new TextEditingController();
  static TextEditingController entryRule2 = new TextEditingController();
  static TextEditingController enterPair = new TextEditingController();

  static TextEditingController journalIndex = new TextEditingController();
  static TextEditingController pairtraded = new TextEditingController();
  static TextEditingController date = new TextEditingController();
  static TextEditingController timeNow = new TextEditingController();
  static TextEditingController tradeNO = new TextEditingController();
  static TextEditingController valid = new TextEditingController();
  static TextEditingController why = new TextEditingController();
  static TextEditingController doneDiff = new TextEditingController();
  static TextEditingController keepDoing = new TextEditingController();
  static TextEditingController notDo = new TextEditingController();
  static TextEditingController comments = new TextEditingController();

  static TextEditingController addLabel = new TextEditingController();
  static TextEditingController labelValue = new TextEditingController();
  static Color firstColor = Color(0xff64AFD3);
  static Color secondColor = Color(0xff314980);

  static int showJounal = 0;
  static int counterViewJournal = 0;
  static bool valueAdd = false;
  static var arr = new List(100);
}
