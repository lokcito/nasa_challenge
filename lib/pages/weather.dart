import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nasa_challenge/widgets/date.dart';
import 'package:nasa_challenge/widgets/day.bar.dart';
import 'package:nasa_challenge/widgets/day.slider.dart';

/// The home screen
class WeatherScreen extends StatelessWidget {
  /// Constructs a [WeatherScreen]
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Clima Actual',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Color(0XFFF0F9FF),
        ),
        body: Container(
            color: Color(0xFFF0F9FF),
            child: Column(
              children: [
                Row(
                  children: [DateWidget()],
                ),
                DayBarWidget(),
                SizedBox(
                  height: 24,
                ),
                DaySliderWidget()
              ],
            )),
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          shape: CircularNotchedRectangle(),
          notchMargin: 8.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.home),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.settings),
                onPressed: () {},
              ),
            ],
          ),
        ));
  }
}
