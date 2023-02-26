import 'package:flutter/material.dart';
import 'rater.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: RaterDemo());
  }
}

class RaterDemo extends StatefulWidget {
  @override
  State<RaterDemo> createState() => _RaterDemoState();
}

class _RaterDemoState extends State<RaterDemo> {
  int rate = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Rater Package")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
    
          children: [
            Rater(
              onChangeRating: (rating) {
                setState(() {
                  rate = rating;
                });
              },
              activeColor: Colors.blue,
              inActiveColor: Colors.blue.shade100,
              direction: Axis.horizontal,
              lables: ["Worse", "Bad", "Okay", "Good", "Better"],
              enableLable: true,
              iconSize: 35,
              rateOutOf: 5,
              iconData: Icons.star,
              initialRating: 4,
              activeLableStyle: TextStyle(color: Colors.blue),
              inActiveLableStyle: TextStyle(color: Colors.grey),
              entityPadding: EdgeInsets.symmetric(horizontal: 10),
              entityWidth: 40,
              verticalLabelSpace: 10,
            ),
            SizedBox(height: 30,),
            Text("Rating count: $rate")
          ],
        ),
      ),
    );
  }
}
