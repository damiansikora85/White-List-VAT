import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:appcenter/appcenter.dart';
import 'package:appcenter_analytics/appcenter_analytics.dart';
import 'package:appcenter_crashes/appcenter_crashes.dart';

import 'error.dart';
import 'subject.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'White List',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Biała list podatników'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final String _serverTest = 'https://wl-test.mf.gov.pl/';
  final String _serverProd = 'https://wl-api.mf.gov.pl';

  String _foundName = "";
  String _foundNip = "";
  final myController = TextEditingController();
  Subject _subject = null;

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 12
          ),
          child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(
              vertical: 12
              ),
              child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'NIP',
              ),
              controller: myController,
              keyboardType: TextInputType.number,
              )
            ),
            ButtonTheme(
              minWidth: double.infinity,
              height: 64,
              child:RaisedButton(
                color: Colors.blueAccent,
                textColor: Colors.white,
                child: Text('Sprawdź'), onPressed: () async {
                  FocusScope.of(context).requestFocus(new FocusNode());
                  var response = await http.get(_serverProd+'/api/search/nip/'+myController.text+'?date=2019-10-24');
                  var responseJson = json.decode(response.body);
                  if(response.statusCode == 200)
                  {
                    if(responseJson['result'] != null && responseJson['result']['subject'] != null)
                    {
                      _subject = Subject.fromJson(responseJson['result']['subject']);

                      setState(() {
                      _foundName = _subject.name;
                      _foundNip = _subject.nip; 
                      });
                    }
                  }
                  else
                  {
                    var error = VatError.fromJson(responseJson);
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Wystąpił problem'),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: <Widget>[
                                Text(error.message+' ('+error.code+')'),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            FlatButton(
                              child: Text('Rozumiem'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      }
                    );
                  }
                },
              ),
            ),
            Expanded(
              child: ListView(
              padding: const EdgeInsets.all(8),
              children: createList(),
            ),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> createList() 
  {
    var fontSmall = 12.0;
    var fontBig = 18.0;
    var elements = new List<Widget>();

    if(_subject != null)
    {
      elements.add(Text('Nazwa',
        textAlign: TextAlign.start,
        style: TextStyle(
          fontSize: fontSmall,
          ),
        )
      );

      elements.add(Text(_subject.name,
        textAlign: TextAlign.start,
        style: TextStyle(
            fontSize: fontBig,
            ),
          )
        );

      elements.add(Divider());

      elements.add(Text('NIP',
        textAlign: TextAlign.start,
        style: TextStyle(
          fontSize: fontSmall,
          ),
        )
      );
      
      elements.add(Text(_subject.nip,
        textAlign: TextAlign.start,
        style: TextStyle(
            fontSize: fontBig,
            ),
          )
        );
      elements.add(Divider());

      elements.add(Text('Numery kont',
        textAlign: TextAlign.start,
        style: TextStyle(
          fontSize: fontSmall,
          ),
        )
      );
      if(_subject.accounts.length > 0)
      {
        for(var account in _subject.accounts)
        {
          elements.add(Text(account,
          textAlign: TextAlign.start,
          style: TextStyle(
              fontSize: fontBig,
              ),
            )
          );
        }
      }
      else
      {
        elements.add(Text('Brak',
        textAlign: TextAlign.start,
        style: TextStyle(
            fontSize: fontBig,
            ),
          )
        );
      }
      elements.add(Divider());

      elements.add(Text('Status VAT',
        textAlign: TextAlign.start,
        style: TextStyle(
          fontSize: fontSmall,
          ),
        )
      );
      
      elements.add(Text(_subject.statusVat,
        textAlign: TextAlign.start,
        style: TextStyle(
            fontSize: fontBig,
            ),
          )
        );
        elements.add(Divider());
    }
    return elements;
  }
}
