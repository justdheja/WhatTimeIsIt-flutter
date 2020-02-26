import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location; //loct name for the ui
  String time; //time in loct
  String flag; //url to an asset for flag
  String url; //loct url for api endpoint
  bool isDayTime; //is daytime or not

  WorldTime({ this.location, this.time, this.flag, this.url });

  Future<void> getTime() async{

    try {
      Response response = await get('http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);
      // print(data);
      
      //get properties from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1,3);
      // print(datetime);
      // print(offset);

      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      //set time property
      isDayTime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
    }
    catch (e) {
      print('Err msg: $e');
      time = 'Somethings Wrong';
    }

    //make request
    
  }

}

