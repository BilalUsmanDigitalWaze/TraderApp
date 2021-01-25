import 'package:timezone/timezone.dart' as tz;
import 'package:flutter/services.dart';

class TimeHelperService {
TimeHelperService() {
    setup();
  }
void setup() async {
    var byteData = await rootBundle.load('packages/timezone/data/2020d.tzf');
    tz.initializeDatabase(byteData.buffer.asUint8List());
  }

  void convertLocalToDetroit() async {
DateTime currentTime = DateTime.now(); //Emulator time is India time
 print('timeZoneCurrent ${currentTime.timeZoneName}');

  final detroitTime =
      new tz.TZDateTime.from(currentTime, tz.getLocation('Europe/Berlin'));
print('Local India Time: ' + currentTime.toString());
  print('Europe/Berlin: ' + detroitTime.timeZoneOffset.toString());



  var detroit = tz.getLocation('America/Detroit');
  var now = tz.TZDateTime.now(detroit);

}
}