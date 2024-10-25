import 'package:flutter/material.dart';
import 'package:weather_app/additional_info_item.dart';
import 'dart:ui';
import 'package:http/http.dart' as http;

import 'package:weather_app/hourly_forecast_item.dart';
import 'package:weather_app/secrets.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {

  @override
  void initState() {
    super.initState();
    getCurrentWeather();
  }
  
  Future getCurrentWeather()async{
    String cityName='London';
   final res= await http.get(
      Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$cityName&APPID=$openWeatherApiKey')
    );
    print(res.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Weather App',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.refresh)),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //main card
              SizedBox(
                width: double.infinity,
                child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                        child: const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Text(
                                '300 k',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 15),
                              Icon(Icons.cloud, size: 64),
                              SizedBox(height: 15),
                              Text('Rain',
                                  style: TextStyle(
                                    fontSize: 20,
                                  ))
                            ],
                          ),
                        ),
                      ),
                    )),
              ),
              const SizedBox(height: 50),
//weather forecast card
              const Text(
                'Weather Forecast',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    HourlyForecastItem(time:'9:00',icon:Icons.cloud, temp:'301'),
                    HourlyForecastItem(time:'10:00',icon:Icons.sunny, temp:'32'),
                    HourlyForecastItem(time:'11:00',icon:Icons.water, temp:'303'),
                    HourlyForecastItem(time:'12:00',icon:Icons.thunderstorm, temp:'304'),
                    HourlyForecastItem(time:'13:00',icon:Icons.cloud, temp:'305'),
                  ],
                ),
              ),

              const SizedBox(height: 50),

              //additional info

              const Text(
                'Additional Information',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AdditionalInfoItem(
                        icon: Icons.water_drop, label: 'Humidity', value: '94'),
                    AdditionalInfoItem(
                        icon: Icons.air, label: 'Wind Speed', value: '7.04'),
                    AdditionalInfoItem(
                        icon: Icons.umbrella, label: 'Pressure', value: '1002'),
                  ]),
            ],
          ),
        ));
  }
}
