import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import '../util/utils.dart' as util;
import 'package:http/http.dart' as http;
import './changCity.dart';

class Klimatic extends StatefulWidget {
  _KlimaticState createState() => _KlimaticState();
}

class _KlimaticState extends State<Klimatic> {
  String _cityEntered;
  Future _goToNextScreen(BuildContext context) async{
    Map results = await Navigator.of(context).push(
      new MaterialPageRoute<Map>(builder: (BuildContext context){
        return new ChangeCity();
      })
    );

    if (results !=null && results.containsKey('enter')){
      print(results['enter'].toString());
      _cityEntered = results['enter'].toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
       appBar: new AppBar(
         title: new Text(
           'Klimatic',
           style: new TextStyle( color: Colors.black, fontWeight: FontWeight.w700),
           ),
         backgroundColor: Colors.yellow,
         centerTitle: true,
         actions: <Widget>[
           new IconButton(
             icon: new Icon(Icons.menu),
             color: Colors.black,
             onPressed: () { _goToNextScreen(context); }
           )
         ],
       ),
       body: new Stack(
         children: <Widget>[
           new Center(
             child: new Image.asset('images/umbrella_yellow.jpeg',
             width: 490.0,
             height: 1200.0,
             fit: BoxFit.fill,),
           ),

           new Container(
             alignment: Alignment.topRight,
             margin: const EdgeInsets.fromLTRB(0.0, 10.9, 20.9, 0.0),
             child: new Text(
               "${ _cityEntered == null ? util.defaultCity : _cityEntered}",
             style: cityStyle()),
           ),

            new Container(
             alignment: Alignment.center,
             child: new Image.asset('images/light_rain.png'),
            ),

            new Container(
            // margin: const EdgeInsets.fromLTRB(left, top, right, bottom)
            margin: const EdgeInsets.fromLTRB(100.0, 90.0, 0.0, 0.0),
             child: updateTempWidget(_cityEntered),
            )

         ],
       ),
    );
  }

    // Call API
    // Return as json format
    Future<Map> getWeather(String appId, String city) async {
      String apiUrl = 'http://api.openweathermap.org/data/2.5/weather?q=$city&appid=${util.appId}&units=metric';
      http.Response response = await http.get(apiUrl);
      return json.decode(response.body);
    }

    // Display response from API
    Widget updateTempWidget(String city){
      return new FutureBuilder(
          future: getWeather(util.appId, city ==  null ? util.defaultCity:city),
          builder: (BuildContext context, AsyncSnapshot<Map> snapshot){
            if(snapshot.hasData){
              Map content = snapshot.data;
              return new Container(
                child: new Column(
                  children: <Widget>[
                    new ListTile(
                      title: new Text(
                        "${content['main']['temp'].toString()} C",
                        style: tempStyle(),
                      ),
                      subtitle: new ListTile(
                       title: new Text(
                        "ຄວາມຊຸ່ມ: ${content['main']['humidity'].toString()}\n"
                         "  ຕໍ່າສຸດ: ${content['main']['temp_min'].toString()} C\n"
                         "  ສູງສຸດ: ${content['main']['temp_max'].toString()} C\n",

                         style: extraData(),
                       ),
                      )

                    )
                  ],
                )
              );
            }else{
              return new Container();
            }
          }
      );
    }
}

TextStyle cityStyle() {
  return new TextStyle(
    color: Colors.white,
    fontSize: 22.9,
    fontStyle: FontStyle.italic
  );
}
TextStyle extraData() {
  return new TextStyle(
    fontStyle: FontStyle.normal,
    fontSize: 19.9,
    color: Colors.white,
    fontWeight: FontWeight.w500
  );
}

TextStyle tempStyle() {
  return new TextStyle(
   color: Colors.white,
   fontStyle: FontStyle.normal,
   fontWeight: FontWeight.w500,
   fontSize: 49.9
  );
}