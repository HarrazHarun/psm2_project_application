// ignore_for_file: file_names

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:psm2_project_application/shared/loading.dart';
import 'package:tflite/tflite.dart';
import 'package:camera/camera.dart';
import 'mapbox.dart';

class ObjectDetectionPage extends StatefulWidget {
  @override
  _ObjectDetectionPageState createState() => _ObjectDetectionPageState();
}

class _ObjectDetectionPageState extends State<ObjectDetectionPage> {
  List _recognitions;
  List<CameraDescription> cameras = [];
  double _imageHeight;
  double _imageWidth;
  CameraImage img;
  CameraController controller;
  bool isBusy = false;
  String result = "";
  bool loading = true;

  @override
  void initState() {
    super.initState();
    calledInit();
  }

  calledInit() async {
    await loadModel();

    await initCamera();
    setState(() {
      loading = false;
    });
  }

  loadModel() async {
    Tflite.close();
    try {
      String res = await Tflite.loadModel(
        model: "assets/yolotiny-psm2.tflite",
        labels: "assets/labels.txt",
        // useGpuDelegate: true,
      );
      print(res);
    } on PlatformException {
      print('Failed to load model.');
    }
  }

  initCamera() async {
    cameras = await availableCameras();
    controller = CameraController(cameras[0], ResolutionPreset.medium);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {
        controller.startImageStream((image) => {
              if (!isBusy) {isBusy = true, img = image, runModelOnFrame()}
            });
      });
    });
  }

  //TODO process frame
  runModelOnFrame() async {
    _imageWidth = img.width + 0.0;
    _imageHeight = img.height + 0.0;
    _recognitions = (await Tflite.detectObjectOnFrame(
      bytesList: img.planes.map((plane) {
        return plane.bytes;
      }).toList(),
      model: "YOLO",
      imageHeight: img.height,
      imageWidth: img.width,
      imageMean: 0,
      //127.5  // 0
      imageStd: 255.0,
      //127.5  //255.0
      numResultsPerClass: 1,
      threshold: 0.4,
    ));
    print(_recognitions.length);
    isBusy = false;
    setState(() {
      img;
    });
  }

  // @override
  // void dispose() {
  //   super.dispose();
  //   controller!.stopImageStream();
  //   Tflite.close();
  // }

  List<Widget> renderBoxes(Size screen) {
    if (_recognitions == null) return [];
    if (_imageHeight == null || _imageWidth == null) return [];
    double factorX = screen.width;
    debugPrint("double factor x");
    double factorY = _imageHeight; // _imageWidth * screen.width;
    Color blue = Color.fromRGBO(37, 213, 253, 1.0);
    return _recognitions.map((re) {
      return Positioned(
        left: re["rect"]["x"] * factorX,
        top: re["rect"]["y"] * factorY,
        width: re["rect"]["w"] * factorX,
        height: re["rect"]["h"] * factorY,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            border: Border.all(
              color: blue,
              width: 2,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "${re["detectedClass"]} ${(re["confidenceInClass"] * 100).toStringAsFixed(0)}%",
                style: TextStyle(
                  background: Paint()..color = blue,
                  color: Colors.red,
                  fontSize: 15.0,
                ),
              ),
              Text(
                'SLOW DOWN!',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
              Text(
                '(Person or Traffic Sign Detected.)',
                style: TextStyle(fontSize: 10, color: Colors.black87),
              ),
            ],
          ),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> stackChildren = [];
    if (loading == false) {
      Size size = MediaQuery.of(context).size;

      stackChildren.add(
        Positioned(
          top: 0.0,
          left: 0.0,
          width: size.width,
          height: size.height - 100,
          child: Container(
            height: size.height - 100,
            child: (!controller.value.isInitialized)
                ? new Container()
                : AspectRatio(
                    aspectRatio: controller.value.aspectRatio,
                    child: CameraPreview(controller),
                  ),
          ),
        ),
      );
      //setState(() => loading = false);

      //   //TODO rectangle round detected objects
      if (img != null) {
        stackChildren.addAll(renderBoxes(size));
      }

      stackChildren.add(
        Container(
          height: size.height,
          alignment: Alignment.bottomCenter,
          child: Container(
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // RaisedButton(
                //   onPressed: () {
                //     Navigator.pop(context);
                //   },
                //   child: Text('back'),
                // )
              ],
            ),
          ),
        ),
      );
    }

    return SafeArea(
      child: /*loading ? Loading() : */ Scaffold(
        backgroundColor: Colors.black,
        body: loading
            ? Loading()
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 2,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.red,
                      child: Stack(
                        children: stackChildren,
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height / 2,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.red,
                      child: Mapbox(),
                    ),
                    Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.blue,
                        child: RaisedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('back'),
                        ))
                  ],
                ),
              ),
      ),
    );
  }
}
