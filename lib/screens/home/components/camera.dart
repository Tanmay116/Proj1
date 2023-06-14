import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:proj1/main.dart';
import 'package:proj1/screens/home/components/img_preview.dart';
import 'package:tflite/tflite.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  CameraImage? cameraImage;
  CameraController? cameraController;
  String output = '';

  @override
  void initState() {
    super.initState();
    loadCamera();
    loadModel();
  }

  loadCamera() {
    cameraController = CameraController(cameras![1], ResolutionPreset.medium);
    cameraController!.initialize().then((value) {
      if (!mounted) {
        return;
      } else {
        setState(() {
          cameraController!.startImageStream((ImageStream) {
            cameraImage = ImageStream;
            runModel();
          });
        });
      }
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // print('Access was Denied');
            break;
          default:
            // print(e.description);
            break;
        }
      }
    });
  }

  runModel() async {
    if (cameraImage != null) {
      var predictions = await Tflite.runModelOnFrame(
          bytesList: cameraImage!.planes.map((plane) {
            return plane.bytes;
          }).toList(),
          imageHeight: cameraImage!.height,
          imageWidth: cameraImage!.width,
          imageMean: 127.5,
          imageStd: 127.5,
          rotation: 90,
          numResults: 2,
          threshold: 0.1,
          asynch: true,
          );
          predictions!.forEach((element) {
            setState(() {
              output = element['label'];
            });
          });

    }
  }

  loadModel() async {
    await Tflite.loadModel(model: 'assets/model.tflite',
    labels: 'assets/labels.txt');
  }

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    return Scaffold(
      appBar: AppBar(title: const Text('Camera')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              width: MediaQuery.of(context).size.height * 0.7,
              child: !cameraController!.value.isInitialized
                  ? Container()
                  : AspectRatio(
                      aspectRatio: cameraController!.value.aspectRatio,
                      child: CameraPreview(cameraController!),
                    ),
            ),
          ),
          Text(output,style: TextStyle(fontWeight: FontWeight.bold,
          fontSize: 20),),
          // Center(
          //   child: ElevatedButton(
          //       onPressed: () async {
          //         // if (cameraController!.value.isInitialized) {
          //         //   print('is initialized');
          //         //   return null;
          //         // }
          //         // if (cameraController!.value.isTakingPicture) {
          //         //   print('is taking pic');
          //         //   return null;
          //         // }
          //         try {
          //           cameraController!.setFlashMode(FlashMode.off);
          //           XFile picture = await cameraController!.takePicture();
          //           // print('took pic');
          //           Navigator.push(
          //               context,
          //               MaterialPageRoute(
          //                 builder: (context) => ImgPreview(file: picture),
          //               ));
          //           // print(picture.runtimeType);
          //         } catch (e) {
          //           debugPrint("error occured while taking pcture: $e");
          //           return;
          //         }
          //       },
          //       child: const Text('Take a picture')),
          // )
        ],
      ),
    );
  }
}
