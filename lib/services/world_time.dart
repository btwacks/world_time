import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {

  String location; // location name for the UI
  String time;     // time in that location
  String flag;     // url to an asset flag icon
  String url;      // location url for api endpoint
  bool isDaytime;  // True or False if daytime or not

  WorldTime({ this.location, this.flag, this.url });

  Future<void> getTime() async {

    try {
      // make the request
      Response response = await get(Uri.parse('https://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);
      // print(data);

      // get properties from json data
      String datetime = data['utc_datetime'];
      String offset = data['utc_offset'].substring(1,3);
      // print(datetime);
      // print(offset);

      // create a datetime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      // set the time property
      isDaytime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
    }
    catch (e) {
      print('caught error $e');
      time = 'could not get time data';
    }



  }

}
