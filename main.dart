import 'package:flutter/material.dart';
import 'package:weather/model/weather_model.dart';
import 'package:weather/services/weather_api_client.dart';
import 'package:weather/views/additional_information.dart';
import 'package:weather/views/current_weather.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false, // Set this to false
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WeatherApiClient client = WeatherApiClient();

  Weather? data;

  Future<void> getData() async {
    data = await client.getCurrentWeather("Kandy");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf9f9f9),
      appBar: AppBar(
        backgroundColor: const Color(0xFFf9f9f9),
        elevation: 0.0,
        title: const Text(
          "Weather App",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu),
          color: Colors.black,
        ),
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                currentWeather(Icons.wb_sunny_rounded, "${data!.temp}",
                    "${data!.cityName}"),
                const SizedBox(
                  height: 60.0,
                ),
                const Text(
                  "Additional Information",
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Color(0xdd212121),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Divider(),
                const SizedBox(
                  height: 20.0,
                ),
                additionalInformation("${data!.wind}", "${data!.humidity}",
                    "${data!.pressure}", "${data!.feelsLike}"),
              ],
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Container();
        },
      ),
    );
  }
}
