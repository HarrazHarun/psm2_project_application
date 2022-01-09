import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_mapbox_navigation/library.dart';

class Mapbox extends StatefulWidget {
  @override
  _MapboxState createState() => _MapboxState();
}

class _MapboxState extends State<Mapbox> {
  String _platformVersion = 'Unknown';
  String _instruction = "";
  final _origin = WayPoint(
      name: "Pintu Gerbang UTeM", latitude: 2.30480, longitude: 102.31688);
  final _stop1 = WayPoint(
      name: "Masjid Sayyidina Abu Bakar UTeM",
      latitude: 2.31212,
      longitude: 102.31838);
  final _stop2 = WayPoint(
      name: "Fakulti Teknologi Maklumat dan Komunikasi (FTMK)",
      latitude: 2.308101,
      longitude: 102.318936);
  final _stop3 = WayPoint(
      name: "Dewan Canselor, UTeM", latitude: 2.31138, longitude: 102.32182);
  final _stop4 = WayPoint(
      name: "Kolej kediaman Satria", latitude: 2.30992, longitude: 102.31450);
  final _stop5 = WayPoint(
      name: "Perpustakaan UTeM", latitude: 2.308833, longitude: 102.320274);
  final _stop6 = WayPoint(
      name: "Pejabat Canselori", latitude: 2.313496, longitude: 102.321298);

  MapBoxNavigation _directions;
  MapBoxOptions _options;

  bool _isMultipleStop = false;
  double _distanceRemaining, _durationRemaining;
  MapBoxNavigationViewController _controller;
  bool _routeBuilt = false;
  bool _isNavigating = false;

  @override
  void initState() {
    super.initState();
    initialize();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initialize() async {
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    _directions = MapBoxNavigation(onRouteEvent: _onEmbeddedRouteEvent);
    _options = MapBoxOptions(
        //initialLatitude: 36.1175275,
        //initialLongitude: -115.1839524,
        zoom: 15.0,
        tilt: 0.0,
        bearing: 0.0,
        enableRefresh: false,
        alternatives: true,
        voiceInstructionsEnabled: true,
        bannerInstructionsEnabled: true,
        allowsUTurnAtWayPoints: true,
        mode: MapBoxNavigationMode.drivingWithTraffic,
        units: VoiceUnits.imperial,
        simulateRoute: false,
        animateBuildRoute: true,
        longPressDestinationEnabled: true,
        language: "en");

    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await _directions.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text('Running on: $_platformVersion\n'),
                      Container(
                        color: Colors.grey,
                        width: double.infinity,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: (Text(
                            "Full Screen Navigation",
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          )),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            child: Text("Go To Masjid UTeM "),
                            onPressed: () async {
                              var wayPoints = <WayPoint>[];
                              wayPoints.add(_origin);
                              wayPoints.add(_stop1);

                              await _directions.startNavigation(
                                  wayPoints: wayPoints,
                                  options: MapBoxOptions(
                                      mode: MapBoxNavigationMode
                                          .drivingWithTraffic,
                                      simulateRoute: false,
                                      language: "en",
                                      units: VoiceUnits.metric));
                            },
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          ElevatedButton(
                            child: Text("Go to FTMK "),
                            onPressed: () async {
                              var wayPoints = <WayPoint>[];
                              wayPoints.add(_origin);
                              wayPoints.add(_stop2);

                              await _directions.startNavigation(
                                  wayPoints: wayPoints,
                                  options: MapBoxOptions(
                                      mode: MapBoxNavigationMode
                                          .drivingWithTraffic,
                                      simulateRoute: false,
                                      language: "en",
                                      units: VoiceUnits.metric));
                            },
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            child: Text("Go To Dewan Canselor "),
                            onPressed: () async {
                              var wayPoints = <WayPoint>[];
                              wayPoints.add(_origin);
                              wayPoints.add(_stop3);

                              await _directions.startNavigation(
                                  wayPoints: wayPoints,
                                  options: MapBoxOptions(
                                      mode: MapBoxNavigationMode
                                          .drivingWithTraffic,
                                      simulateRoute: false,
                                      language: "en",
                                      units: VoiceUnits.metric));
                            },
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          ElevatedButton(
                            child: Text("Go to Kediaman Satria "),
                            onPressed: () async {
                              var wayPoints = <WayPoint>[];
                              wayPoints.add(_origin);
                              wayPoints.add(_stop4);

                              await _directions.startNavigation(
                                  wayPoints: wayPoints,
                                  options: MapBoxOptions(
                                      mode: MapBoxNavigationMode
                                          .drivingWithTraffic,
                                      simulateRoute: false,
                                      language: "en",
                                      units: VoiceUnits.metric));
                            },
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            child: Text("Go To Library UTeM "),
                            onPressed: () async {
                              var wayPoints = <WayPoint>[];
                              wayPoints.add(_origin);
                              wayPoints.add(_stop5);

                              await _directions.startNavigation(
                                  wayPoints: wayPoints,
                                  options: MapBoxOptions(
                                      mode: MapBoxNavigationMode
                                          .drivingWithTraffic,
                                      simulateRoute: false,
                                      language: "en",
                                      units: VoiceUnits.metric));
                            },
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          ElevatedButton(
                            child: Text("Go to Pejabat Canselori  "),
                            onPressed: () async {
                              var wayPoints = <WayPoint>[];
                              wayPoints.add(_origin);
                              wayPoints.add(_stop6);

                              await _directions.startNavigation(
                                  wayPoints: wayPoints,
                                  options: MapBoxOptions(
                                      mode: MapBoxNavigationMode
                                          .drivingWithTraffic,
                                      simulateRoute: false,
                                      language: "en",
                                      units: VoiceUnits.metric));
                            },
                          ),
                        ],
                      ),
                      Container(
                        color: Colors.grey,
                        width: double.infinity,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: (Text(
                              _instruction == null || _instruction.isEmpty
                                  ? "Banner Instruction Here"
                                  : _instruction,
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.center)),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 20.0, right: 20, top: 20, bottom: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text("Duration Remaining: "),
                                Text(_durationRemaining != null
                                    ? "${(_durationRemaining / 60).toStringAsFixed(0)} minutes"
                                    : "---")
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Text("Distance Remaining: "),
                                Text(_distanceRemaining != null
                                    ? "${(_distanceRemaining * 0.000621371).toStringAsFixed(1)} miles"
                                    : "---")
                              ],
                            ),
                          ],
                        ),
                      ),
                      Divider()
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.grey,
                  child: MapBoxNavigationView(
                      options: _options,
                      onRouteEvent: _onEmbeddedRouteEvent,
                      onCreated:
                          (MapBoxNavigationViewController controller) async {
                        _controller = controller;
                        controller.initialize();
                      }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onEmbeddedRouteEvent(e) async {
    _distanceRemaining = await _directions.distanceRemaining;
    _durationRemaining = await _directions.durationRemaining;

    switch (e.eventType) {
      case MapBoxEvent.progress_change:
        var progressEvent = e.data as RouteProgressEvent;
        if (progressEvent.currentStepInstruction != null)
          _instruction = progressEvent.currentStepInstruction;
        break;
      case MapBoxEvent.route_building:
      case MapBoxEvent.route_built:
        setState(() {
          _routeBuilt = true;
        });
        break;
      case MapBoxEvent.route_build_failed:
        setState(() {
          _routeBuilt = false;
        });
        break;
      case MapBoxEvent.navigation_running:
        setState(() {
          _isNavigating = true;
        });
        break;
      case MapBoxEvent.on_arrival:
        if (!_isMultipleStop) {
          await Future.delayed(Duration(seconds: 3));
          await _controller.finishNavigation();
        } else {}
        break;
      case MapBoxEvent.navigation_finished:
      case MapBoxEvent.navigation_cancelled:
        setState(() {
          _routeBuilt = false;
          _isNavigating = false;
        });
        break;
      default:
        break;
    }
    setState(() {});
  }
}
