import 'dart:ui';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
// Ensure this path is correct for your project structure
import 'package:weather_app/bloc/weather_bloc_bloc.dart';
// You might need to define WeatherBlocState, WeatherBlocSuccess, WeatherBlocLoading,
// WeatherBlocInitial, WeatherBlocFailure if they are not exported by weather_bloc_bloc.dart
// For example, if they are in a separate file:
// import 'package:weather_app/bloc/weather_bloc_state.dart';

const String YOUR_NAME = "Sourav Jyoti Sahariah";

const String ABOUT_ME_SUMMARY = """
Hi! I'm Sourav Jyoti Sahariah, a B.Tech Computer Science and Engineering student at Assam down town University. 
I'm passionate about building AI-driven applications, full-stack systems, and impactful tech solutions.

Key Skills: Flutter, Python, OpenCV, ML/DL, Django, Flask, Dart, MySQL

Projects I've built include:
- AI Fake News Detector
- Legal AI Chatbot
- TrackGuard IoT Security System
- SafeWalk Women’s Safety App
- YouTube Downloader, and more

Let's connect:
GitHub: github.com/jack026  
LinkedIn: linkedin.com/in/sourav-jyoti-sahariah
""";

const String PM_ACCELERATOR_DESCRIPTION = """
Product Manager Accelerator empowers aspiring and current product managers with the skills, 
knowledge, and network to excel in their careers. We provide hands-on training, mentorship, 
and real-world project experience to accelerate your journey into product leadership.
""";

// REPLACE THIS WITH ACTUAL TEXT FROM THEIR LINKEDIN

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> _refreshWeather(BuildContext context) async {
    // This assumes your WeatherBlocBloc has a method `fetchWeatherData`.
    // If it uses events, it should be:
    // BlocProvider.of<WeatherBlocBloc>(context).add(YourFetchEvent());
    await BlocProvider.of<WeatherBlocBloc>(context).fetchWeatherData();
  }

  String _getGreeting() {
    var hour = DateTime.now().hour;
    if (hour >= 5 && hour < 12) {
      return 'Good Morning';
    } else if (hour >= 12 && hour < 17) {
      return 'Good Afternoon';
    } else if (hour >= 17 && hour < 22) {
      return 'Good Evening';
    } else {
      return 'Good Night';
    }
  }

  Widget getDayWeatherIcon(int code) {
    switch (code) {
      case >= 200 && < 300:
        return Image.asset('assets/day1.png');
      case >= 300 && < 400:
        return Image.asset('assets/day2.png');
      case >= 500 && < 600:
        return Image.asset('assets/day3.png');
      case >= 600 && < 700:
        return Image.asset('assets/day4.png');
      case >= 700 && < 800:
        return Image.asset('assets/day5.png');
      case == 800:
        return Image.asset('assets/day6.png');
      case > 800 && <= 804:
        return Image.asset('assets/day7.png');
      default:
        return Image.asset('assets/day8.png');
    }
  }

  Widget getNightWeatherIcon(int code) {
    switch (code) {
      case >= 200 && < 300:
        return Image.asset('assets/night1.png');
      case >= 300 && < 400:
        return Image.asset('assets/night2.png');
      case >= 500 && < 600:
        return Image.asset('assets/night3.png');
      case >= 600 && < 700:
        return Image.asset('assets/night4.png');
      case >= 700 && < 800:
        return Image.asset('assets/night5.png');
      case == 800:
        return Image.asset('assets/night6.png');
      case > 800 && <= 804:
        return Image.asset('assets/night7.png');
      default:
        return Image.asset('assets/night8.png');
    }
  }

  // Function to show the info dialog
  void _showInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) { // Renamed to avoid conflict with outer context
        return AlertDialog(
          title: const Text('About This Application'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Developed by: $YOUR_NAME', style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                const Text('About My Development:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 5),
                Text(ABOUT_ME_SUMMARY),
                const Divider(height: 30, thickness: 1),
                const Text('About Product Manager Accelerator:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 5),
                Text(PM_ACCELERATOR_DESCRIPTION),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Use dialogContext here
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.info_outline, color: Colors.white), // Added color for visibility
            tooltip: 'Information',
            onPressed: () {
              _showInfoDialog(context); // Call the function to show dialog
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => _refreshWeather(context),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(40, 1.2 * kToolbarHeight, 40, 20),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                Align(
                  alignment: const AlignmentDirectional(3, -0.3),
                  child: Container(
                    height: 300,
                    width: 300,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.deepPurple,
                    ),
                  ),
                ),
                Align(
                  alignment: const AlignmentDirectional(-3, -0.3),
                  child: Container(
                    height: 300,
                    width: 300,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF673AB7),
                    ),
                  ),
                ),
                Align(
                  alignment: const AlignmentDirectional(0, -1.2),
                  child: Container(
                    height: 300,
                    width: 600,
                    decoration: DateTime.now().hour >= 5 && DateTime.now().hour < 17
                        ? const BoxDecoration(
                            color: Color(0xFFFFAB40),
                          )
                        : const BoxDecoration(
                            color: Color.fromARGB(255, 78, 53, 253),
                          ),
                  ),
                ),
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
                  child: Container(
                    decoration: const BoxDecoration(color: Colors.transparent),
                  ),
                ),
                Positioned.fill(
  child: DateTime.now().hour >= 5 && DateTime.now().hour < 17
      ? Container() // No stars in day mode
      : Stack(
          children: List.generate(
            70,
            (index) {
              final screenWidth = MediaQuery.of(context).size.width;
              final screenHeight = MediaQuery.of(context).size.height;
              final left = Random().nextDouble() * screenWidth;
              final top = Random().nextDouble() * screenHeight;
              return Positioned(
                left: left,
                top: top,
                child: const Icon(
                  Icons.star,
                  color: Colors.white,
                  size: 2,
                ),
              );
            },
          ),
        ),
),

                BlocBuilder<WeatherBlocBloc, WeatherBlocState>(
                  builder: (context, state) {
                    if (state is WeatherBlocSuccess) {
                      return SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '📍 ${state.weather.areaName}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              _getGreeting(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            DateTime.now().hour >= 5 && DateTime.now().hour < 17
                                ? getDayWeatherIcon(state.weather.weatherConditionCode!)
                                : getNightWeatherIcon(state.weather.weatherConditionCode!),
                            Center(
                              child: Text(
                                '${state.weather.temperature!.celsius!.round()}°C',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 55,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Center(
                              child: Text(
                                state.weather.weatherMain!.toUpperCase(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Center(
                              child: Text(
                                DateFormat('EEEE dd •').add_jm().format(DateTime.now()),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/11.png',
                                      scale: 8,
                                    ),
                                    const SizedBox(width: 5),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Sunrise',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                        const SizedBox(height: 3),
                                        Text(
                                          DateFormat().add_jm().format(state.weather.sunrise!),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/12.png',
                                      scale: 8,
                                    ),
                                    const SizedBox(width: 5),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Sunset',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                        const SizedBox(height: 3),
                                        Text(
                                          DateFormat().add_jm().format(state.weather.sunset!),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 5.0),
                              child: Divider(
                                color: Colors.grey,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/13.png',
                                      scale: 8,
                                    ),
                                    const SizedBox(width: 5),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Temp Max',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                        const SizedBox(height: 3),
                                        Text(
                                          "${state.weather.tempMax!.celsius!.round()} °C",
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/14.png',
                                      scale: 8,
                                    ),
                                    const SizedBox(width: 5),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Temp Min',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                        const SizedBox(height: 3),
                                        Text(
                                          "${state.weather.tempMin!.celsius!.round()} °C",
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                            const Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: Center(
                                child: Text(
                                  'Last updated by SJS ${DateFormat('HH:mm').format(state.weather.date!)}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    } else if (state is WeatherBlocLoading || state is WeatherBlocInitial) {
                      return const Center(child: CircularProgressIndicator(color: Colors.white));
                    } else if (state is WeatherBlocFailure) {
                      return const Center(
                        child: Text(
                          'Failed to load weather data.\nPull to refresh.',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    } else {
                      // Fallback for any other unhandled states
                      return Container();
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Your main app structure to run HomeScreen
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WeatherBlocBloc>(
      create: (context) {
        final bloc = WeatherBlocBloc();
        // Trigger initial data fetch when BLoC is created.
        // Adjust if your BLoC uses events: bloc.add(YourInitialFetchEvent());
        bloc.fetchWeatherData();
        return bloc;
      },
      child: MaterialApp(
        title: 'Weather App',
        theme: ThemeData(
          brightness: Brightness.dark, // Match HomeScreen's dark theme
          primarySwatch: Colors.deepPurple, // Or any color you prefer
        ),
        home: const HomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}