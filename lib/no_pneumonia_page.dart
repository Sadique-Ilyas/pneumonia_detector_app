import 'package:flutter/material.dart';

class NoPneumoniaPage extends StatefulWidget {
  const NoPneumoniaPage({Key? key}) : super(key: key);

  @override
  State<NoPneumoniaPage> createState() => _NoPneumoniaPageState();
}

class _NoPneumoniaPageState extends State<NoPneumoniaPage> {
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
          SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20))),
                  child: Column(
                    children: [
                      Image.asset("assets/images/pn.png"),
                      const Center(
                        child: Text('Your X-ray is NORMAL',
                            style:
                                TextStyle(color: Colors.green, fontSize: 25)),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Center(
                        child: Text(
                          "Dear User, Our machine predicts your X-ray image as NORMAL. Still there are chances of PNEUMONIA.",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Text(
                          'Note:- Though our deep learning model had been trained on large number of x-ray images of both pneumonia as well as normal image with a accuracy of 90%. But still it may predict wrong. So this is not the final report. The result may be varying.',
                          style: TextStyle(
                            color: Colors.yellow.shade200,
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
