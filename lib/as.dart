/* // ignore_for_file: deprecated_member_use, camel_case_types, prefer_const_constructors, unnecessary_null_comparison, prefer_if_null_operators, prefer_final_fields, unnecessary_new, duplicate_ignore, file_names, import_of_legacy_library_into_null_safe, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:weather_app_c4/apfile.dart' as util;
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class climate extends StatefulWidget {
  @override
  _climateState createState() => _climateState();
}

class _climateState extends State<climate> {
  String? _cityEntered;

  Future _gotonextScreen(BuildContext context) async {
    Map? result = await Navigator.of(context)
        .push(MaterialPageRoute<Map>(builder: (BuildContext context) {
      return climateChange();
    }));
    if (result != null && result.containsKey('enter')) {
      setState(() {
        _cityEntered = result['enter'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Climate App'),
        backgroundColor: Colors.red[500],
        actions: [
          IconButton(
              icon: Icon(Icons.change_circle_outlined),
              onPressed: () {
                _gotonextScreen(context);
              }),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Center(
            child: Image(
              image: AssetImage('images/wt.png'),
              height: 1200.0,
              width: 600.0,
              fit: BoxFit.fill,
            ),
          ),
          Container(
            alignment: Alignment.topCenter,
            margin: EdgeInsets.fromLTRB(0.0, 30, 0.0, 0.0),
            child: Text(
              // ignore: unnecessary_null_comparison
              _cityEntered == null ? util.defaultCity : _cityEntered!,
              style: TextStyle(
                  fontSize: 40.0, color: Colors.white, fontFamily: "Helvatic"),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0.0, 250.0, 0.0, 0.0),
            child: updateTempWidget(
                '${_cityEntered == null ? util.defaultCity : _cityEntered}'),
          ),
        ],
      ),
    );
  }

  Future<Map> getweather(String apiId, String city) async {
    var apiUrl =
        'http://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiId&units=imperial';

    http.Response response = await http.get(Uri.parse(apiUrl));
    return json.decode(response.body);
  }

  Widget updateTempWidget(String city) {
    double c = 1.8000;

    return FutureBuilder(
        future: getweather(util.apiID, city == null ? util.defaultCity : city),
        builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
          if (snapshot.hasData) {
            Map? content = snapshot.data;
            return Column(
              children: [
                ListTile(
                  title: Center(
                    child: Text(
                      ((((content!['main']['temp']) - 32) / c))
                              .toStringAsFixed(1) +
                          "°C",
                      style: TextStyle(
                        fontSize: 60.9,
                        color: Colors.black,
                        /* fontWeight: FontWeight.w500 */
                        fontFamily: "Helvatic",
                      ),
                    ),
                  ),
                  subtitle: ListTile(
                    title: Center(
                      child: Text(
                        "Humidity: ${content['main']['humidity'].toString() + "%"}\n",
                        style: TextStyle(
                          fontSize: 17.0,
                          fontStyle: FontStyle.normal,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Container();
          }
        });
  }
}

class climateChange extends StatefulWidget {
  @override
  _climateChangeState createState() => _climateChangeState();
}

class _climateChangeState extends State<climateChange> {
  var _cityFieldController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.red,
        title: Text('Change City'),
      ),
      body: Stack(
        children: [
          new Center(
            child: Image(
              image: AssetImage('images/snow.jpg'),
              width: 490.0,
              height: 1200.0,
              fit: BoxFit.fill,
            ),
          ),
          ListView(
            children: [
              new ListTile(
                title: new TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter City',
                  ),
                  controller: _cityFieldController,
                  keyboardType: TextInputType.text,
                ),
              ),
              new ListTile(
                title: new FlatButton(
                  onPressed: () {
                    Navigator.pop(
                        context, {'enter': _cityFieldController.text});
                  },
                  textColor: Colors.black,
                  color: Colors.redAccent,
                  child: new Text(
                    'Press Enter',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
 */