import 'package:flutter/material.dart';
import 'package:psm2_project_application/mapbox.dart';
import 'package:psm2_project_application/objectDetectionPage.dart';
import 'package:psm2_project_application/shared/loading.dart';
import 'package:shimmer/shimmer.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  //bool loading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: /*loading
            ? Loading()
            : */
            Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(28, 100, 28, 0),
            child: Container(
              height: 550,
              width: 300,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0),
                    topLeft: Radius.circular(20.0),
                    bottomLeft: Radius.circular(20.0),
                  ),
                  color: Colors.blue),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/logoUtem.png',
                      width: 250,
                      height: 250,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Pedestrian Trafic Sign Detection UTeM Navigation System',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(58.0),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(
                                color: Colors.white,
                                width: 2.0,
                              ),
                            ),
                          ),
                        ),
                        child: Shimmer.fromColors(
                          baseColor: Colors.black,
                          highlightColor: Colors.white,
                          child: Text(
                            '        Get Started        ',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ObjectDetectionPage()));
                          //setState(() => loading = true);
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
