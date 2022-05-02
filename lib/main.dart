import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  bool _usePortal = true;

  @override
  void initState() {
    super.initState();

    Timer.periodic(const Duration(seconds: 1), (_) => _incrementCounter());
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  void _toggle() {
    setState(() {
      _usePortal = !_usePortal;
    });
  }

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
        title: Text('_usePortal = $_usePortal, _counter = $_counter'),
      ),
      body: Portal(
        child: ListView.builder(
          itemBuilder: (context, index) {
            final stack = Stack(children: [
              for (var i = 0; i < 8; i++)
                Positioned(
                  left: index % 10 * 20 + i * 40,
                  width: 20,
                  height: 48,
                  child: Container(
                      color: HSLColor.fromAHSL(1, index * 10 % 360, 1, 0.5)
                          .toColor()),
                )
            ]);

            return SizedBox(
                width: double.infinity,
                height: 48,
                child: _usePortal
                    ? PortalTarget(
                        anchor: const Aligned(
                          follower: Alignment.topLeft,
                          target: Alignment.topLeft,
                        ),
                        child: const SizedBox(width: 100, height: 48),
                        portalFollower: stack)
                    : stack);
          },
          itemExtent: 48,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggle,
        tooltip: 'Toggle Portal',
        child: _usePortal
            ? const Icon(Icons.radio_button_checked)
            : const Icon(Icons.radio_button_unchecked),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
