// ignore_for_file: deprecated_member_use, camel_case_types, prefer_const_constructors, unnecessary_null_comparison, prefer_if_null_operators, prefer_final_fields, unnecessary_new, duplicate_ignore, file_names, import_of_legacy_library_into_null_safe, unnecessary_string_interpolations

////////////////////////////////////////////
  ///follor For more ig: @Countrol4offical
  ///@countrolfour@gmail.com
////////////////////////////////////////////
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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 70,
        elevation: 0,
        backgroundColor: Colors.transparent,
        toolbarOpacity: 0.7,
        title: Text(
          'Climate App',
          style: TextStyle(
              fontFamily: "Helvatic",
              fontWeight: FontWeight.bold,
              fontSize: 30),
        ),
        actions: [
          IconButton(
              padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
              icon: Icon(
                Icons.cloud,
                size: 40,
              ),
              onPressed: () {
                _gotonextScreen(context);
              }),
        ],
      ),
      body: Stack(
        children: [
          Center(
            child: Image(
              image: AssetImage(
                'images/c.png',
              ),
              height: 1200.0,
              width: 600.0,
              fit: BoxFit.fill,
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0.0, 70.0, 0.0, 0.0),
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ListTile(
                  title: Container(
                    padding: EdgeInsets.fromLTRB(140, 80, 0, 0),
                    child: Text(
                      ((((content!['main']['temp']) - 32) / c))
                              .toStringAsFixed(0) +
                          "°",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 90.9,
                        color: Colors.white,
                        /* fontWeight: FontWeight.w500 */
                        fontFamily: "Helvatic",
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Icon(
                    Icons.cloud,
                    size: 100,
                    color: Colors.white38,
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  height: 3,
                  width: 350,
                  color: Colors.white54,
                ),
                SizedBox(
                  height: 40,
                ),
                Center(
                  child: Text(
                    // ignore: unnecessary_null_comparison
                    _cityEntered == null ? util.defaultCity : _cityEntered!,
                    style: TextStyle(
                        fontSize: 30.0,
                        color: Colors.white,
                        fontFamily: "Helvatic"),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 220, 0, 0),
                ),
                Container(
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                        child: Text(
                          "Humidity: ",
                          style: TextStyle(
                            fontSize: 17.0,
                            fontStyle: FontStyle.normal,
                            color: Colors.white54,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(208, 0, 0, 0),
                        child: Text(
                          " ${content['main']['humidity'].toString() + "  %"}",
                          style: TextStyle(
                            fontFamily: "Helvatic",
                            fontSize: 20.0,
                            fontStyle: FontStyle.normal,
                            color: Colors.white54,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 1,
                  width: 350,
                  color: Colors.white54,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                        child: Text(
                          "Max: ",
                          style: TextStyle(
                            fontSize: 17.0,
                            fontStyle: FontStyle.normal,
                            color: Colors.white54,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(250, 0, 0, 0),
                        child: Text(
                          "${(((content['main']['temp_max']) - 32) / c).toStringAsFixed(1)} °C",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontStyle: FontStyle.normal,
                            color: Colors.white54,
                            fontFamily: "Helvatic",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 1,
                  width: 350,
                  color: Colors.white54,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                        child: Text(
                          "Min: ",
                          style: TextStyle(
                            fontSize: 17.0,
                            fontStyle: FontStyle.normal,
                            color: Colors.white54,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(250, 0, 0, 0),
                        child: Text(
                          " ${(((content['main']['temp_min']) - 32) / c).toStringAsFixed(1)} °C",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: "Helvatic",
                            fontStyle: FontStyle.normal,
                            color: Colors.white54,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Change City',
          style: TextStyle(
              fontFamily: "Helvatic",
              fontWeight: FontWeight.bold,
              fontSize: 30),
        ),
      ),
      body: Stack(
        children: [
          new Center(
            child: Image(
              image: AssetImage('images/4.png'),
              width: 490.0,
              height: 1200.0,
              fit: BoxFit.fill,
            ),
          ),
          Container(
            child: ListView(
              padding: EdgeInsets.fromLTRB(0, 350, 0, 0),
              children: [
                new ListTile(
                  title: new TextField(
                    decoration: InputDecoration(
                      hintStyle: TextStyle(
                        fontSize: 20,
                      ),
                      hintText: 'Enter City',
                      contentPadding: EdgeInsets.fromLTRB(135.0, 0.0, 0.0, 0.0),
                    ),
                    controller: _cityFieldController,
                    keyboardType: TextInputType.text,
                  ),
                ),
                SizedBox(height: 30),
                new ListTile(
                  title: new TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.orange[700]),
                    onPressed: () {
                      Navigator.pop(
                          context, {'enter': _cityFieldController.text});
                    },
                    child: new Text(
                      'Press Enter',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: "Helvatic",
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
