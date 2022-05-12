import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pneumonia_detector_app/about_page.dart';
import 'package:pneumonia_detector_app/advice_page.dart';
import 'package:pneumonia_detector_app/predict_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent.withOpacity(1),
        title: const Text(
          'PNEUMONIA DETECTOR',
          style: TextStyle(color: Colors.yellow),
        ),
        centerTitle: true,
      ),
      drawer: Drawer(
        backgroundColor: Colors.white.withOpacity(0.8),
        child: ListView(
          children: [
            DrawerHeader(
              padding: const EdgeInsets.all(0),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                ),
                child: const Center(
                  child: Text('Pneumonia Detector',
                      style: TextStyle(color: Colors.yellow, fontSize: 30)),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.donut_small),
              title: const Text('Advice',
                  style: TextStyle(color: Colors.black, fontSize: 20)),
              onTap: () {
                print("Advice");
                Get.to(() => const AdvicePage());
              },
            ),
            ListTile(
              leading: const Icon(Icons.leaderboard),
              title: const Text('About',
                  style: TextStyle(color: Colors.black, fontSize: 20)),
              onTap: () {
                print("About");
                Get.to(() => const AboutPage());
              },
            ),
          ],
        ),
      ),
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'WELCOME !!',
                    style: TextStyle(
                        color: Colors.yellow,
                        fontSize: 50,
                        fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'DETECT PNEUMONIA',
                    style: TextStyle(
                        color: Colors.yellow,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Get.to(() => const PredictPage());
                      },
                      child: const Text(
                        'Predict',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.yellow,
                          padding: const EdgeInsets.all(10)))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
