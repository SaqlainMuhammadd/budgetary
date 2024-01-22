import 'package:flutter/material.dart';

class statisticsScreen extends StatefulWidget {
  const statisticsScreen({super.key});

  @override
  State<statisticsScreen> createState() => _statisticsScreenState();
}

class _statisticsScreenState extends State<statisticsScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Center(child: Text('Statistics')),
          actions: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Icon(Icons.download_rounded),
            )
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.teal,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        textStyle: TextStyle(
                            color: const Color.fromARGB(255, 255, 255, 255)),
                      ),
                      onPressed: () {},
                      child: Text(
                        'Day',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      )),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.teal,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        textStyle: TextStyle(
                            color: const Color.fromARGB(255, 255, 255, 255)),
                      ),
                      onPressed: () {},
                      child: Text(
                        'Week',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      )),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.teal,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        textStyle: TextStyle(
                            color: const Color.fromARGB(255, 255, 255, 255)),
                      ),
                      onPressed: () {},
                      child: Text(
                        'Month',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      )),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.teal,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        textStyle: TextStyle(
                            color: const Color.fromARGB(255, 255, 255, 255)),
                      ),
                      onPressed: () {},
                      child: Text(
                        'Year',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      )),
                ],
              ),
            ),
          ],
        ));
  }
}
