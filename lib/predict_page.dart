import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pneumonia_detector_app/no_pneumonia_page.dart';
import 'package:pneumonia_detector_app/pneumonia_page.dart';
import 'package:tflite/tflite.dart';
import 'package:image_picker/image_picker.dart';

class PredictPage extends StatefulWidget {
  const PredictPage({Key? key}) : super(key: key);

  @override
  State<PredictPage> createState() => _PredictPageState();
}

class _PredictPageState extends State<PredictPage> {
  List? _outputs;
  File? _image;

  @override
  void initState() {
    loadModel().then((value) {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  pickImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return null;
    setState(() {
      _image = File(image.path);
    });
    print('Image: ${_image?.path}');
    // classifyImage(_image!);
  }

  classifyImage(File image) async {
    print("=-====================");
    print("CLASSIFY IMAGE");
    print("=-====================");
    var output = await Tflite.runModelOnImage(
      path: image.path,
    );
    print("predict = " + output.toString());
    setState(() {
      _outputs = output;
    });

    if (_outputs.toString() != [].toString()) {
      print("PNEUMONIA YES !!");
      Get.to(() => const PneumoniaPage());
    } else {
      print("PNEUMONIA NO !!");
      Get.to(() => const NoPneumoniaPage());
    }
  }

  loadModel() async {
    await Tflite.loadModel(
        model: "assets/accuracy_88.tflite", labels: "assets/label.txt");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Image(
            image: AssetImage('assets/images/myno.jpg'),
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20))),
                    child: const Center(
                      child: Text('Detect Pneumonia',
                          style: TextStyle(color: Colors.white, fontSize: 30)),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.5),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20))),
                    child: Column(
                      children: [
                        const Text('Add X-ray Image',
                            style:
                                TextStyle(color: Colors.white, fontSize: 30)),
                        Container(
                          margin: const EdgeInsets.only(top: 5, bottom: 5),
                          height: 200,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              // color: Colors.red,
                              border:
                                  Border.all(color: Colors.black, width: 2)),
                          child: _image == null
                              ? Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text('Image shows here',
                                          style:
                                              TextStyle(color: Colors.white)),
                                      Icon(
                                        Icons.image,
                                        color: Colors.white.withOpacity(0.7),
                                        size: 80,
                                      ),
                                    ],
                                  ),
                                )
                              : Image.file(_image!),
                        ),
                        OutlinedButton(
                          style: ButtonStyle(
                              side: MaterialStateProperty.all<BorderSide>(
                                  const BorderSide(color: Colors.white)),
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              overlayColor: MaterialStateProperty.all<Color>(
                                  Colors.white.withOpacity(0.5))),
                          onPressed: () => pickImage(),
                          child: const Text('Add X-ray Image'),
                        ),
                      ],
                    ),
                  ),
                  // _outputs.toString() != [].toString()
                  //     ? const Text(
                  //         'Yes Pneumonia',
                  //         style: TextStyle(color: Colors.white),
                  //       )
                  //     : const Text(
                  //         'No Pneumonia',
                  //         style: TextStyle(color: Colors.white),
                  //       ),
                  OutlinedButton(
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            const EdgeInsets.only(
                                top: 10, bottom: 10, left: 40, right: 40)),
                        side: MaterialStateProperty.all<BorderSide>(
                            const BorderSide(color: Colors.white)),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        overlayColor: MaterialStateProperty.all<Color>(
                            Colors.white.withOpacity(0.5))),
                    onPressed: () => classifyImage(_image!),
                    child: const Text('Predict'),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
