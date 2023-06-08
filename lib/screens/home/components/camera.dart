import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:proj1/main.dart';
import 'package:proj1/screens/home/components/img_preview.dart';

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
  }

  loadCamera() {
    cameraController = CameraController(cameras![0], ResolutionPreset.medium);
    cameraController!.initialize().then((value) {
      if (!mounted) {
        return;
      } else {
        setState(() {
          cameraController!.startImageStream((ImageStream) {
            cameraImage = ImageStream;
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
          Center(
            child: ElevatedButton(
                onPressed: () async {
                  // if (cameraController!.value.isInitialized) {
                  //   print('is initialized');
                  //   return null;
                  // }
                  // if (cameraController!.value.isTakingPicture) {
                  //   print('is taking pic');
                  //   return null;
                  // }
                  try {
                    cameraController!.setFlashMode(FlashMode.off);
                    XFile picture = await cameraController!.takePicture();
                    // print('took pic');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ImgPreview(file: picture),
                        ));
                    // print(picture.runtimeType);
                  } catch (e) {
                    debugPrint("error occured while taking pcture: $e");
                    return;
                  }
                },
                child: const Text('Take a picture')),
          ) 
        ],
      ),
    );
  }
}
