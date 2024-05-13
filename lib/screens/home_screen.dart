// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, avoid_print, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/weather_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WeatherProvider(),
      child: HomeScreenBody(),
    );
  }
}

class HomeScreenBody extends StatefulWidget {
  const HomeScreenBody({super.key});

  @override
  State<HomeScreenBody> createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<HomeScreenBody> {
  String? location;
  final TextEditingController _locationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    //fetch weather details
    fetchWeatherData();

    // Load saved location
    _loadSavedLocation();
  }

  // Method to load saved location
  void _loadSavedLocation() async {
    String? savedLocation = '';
    setState(() {
      location = savedLocation;
      _locationController.text = location ?? '';
    });
    await fetchWeatherData();
  }

  // Method to fetch weather data
  Future<void> fetchWeatherData() async {
    try {
      if (location == null || location!.isEmpty) {
        await Provider.of<WeatherProvider>(context, listen: false)
            .fetchWeatherByLongLatt();
      } else {
        // Fetch weather data by location name
        await Provider.of<WeatherProvider>(context, listen: false)
            .fetchWeatherByName(location!);
      }
    } catch (e) {
      print('Error fetching weather data: $e');
    }
  }

  // Method to handle Save/Update button press
  void _saveOrUpdateLocation() {
    setState(() {
      location = _locationController.text.trim();
    });

    fetchWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'images/background_image.jpg',
            fit: BoxFit.cover,
          ),
          Consumer<WeatherProvider>(
            builder: (context, value, child) {
              if (value.isLoading) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        color: Colors.yellow,
                      ),
                      Text(
                        '\nLoading...',
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                );
              } else if (value.weatherData == null) {
                return const Center(
                  child: Text('The weather data is empty'),
                );
              } else {
                final detail = value.weatherData;
                return Positioned(
                  top: 40,
                  left: 10,
                  right: 10,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _locationController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          suffixIcon: TextButton(
                            onPressed: _saveOrUpdateLocation,
                            child: Text(
                              location == null || location!.isEmpty
                                  ? 'Save'
                                  : 'Update',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        detail!.current.tempC.toString(),
                        style: TextStyle(color: Colors.white, fontSize: 24.0),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
