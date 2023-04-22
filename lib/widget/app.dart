// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:weatherapp/model/weather_model.dart';
import 'package:weatherapp/widget/service.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  Weather? _response;

  final _controller = TextEditingController();
  void _search() async {
    if (_controller.text.isNotEmpty) {
      Weather? res = await Service.getWeather(_controller.text);

      if (res == null) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: const Text('City not found'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('OK'),
                )
              ],
            );
          },
        );
      } else {
        setState(() => _response = res);
      }
    }
  }

  void _getDefaultWeather() async {
    Weather? res = await Service.getWeather('tbilisi');
    setState(() => _response = res);
  }

  @override
  void initState() {
    _getDefaultWeather();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(232, 235, 235, 235),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_response != null)
              Column(
                children: [
                  Image.network(_response!.iconUrl),
                  Text(
                    '${_response?.main?.temp}°',
                    style: const TextStyle(fontSize: 40),
                  ),
                  Text(
                    '${_response?.weather?[0].description} in ${_response?.name}',
                  ),
                ],
              ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50),
              child: SizedBox(
                width: 150,
                child: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(labelText: 'City'),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            ElevatedButton(onPressed: _search, child: const Text("search"))
          ],
        ),
      ),
    );
  }
}
