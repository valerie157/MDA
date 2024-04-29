import 'package:flutter/material.dart';
import 'package:my_flutter_app/domain/models/services/hotel-service.dart';


import 'package:my_flutter_app/data/dummy.dart';

class MyHomePage extends StatelessWidget {
  final String title;

  const MyHomePage({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(title),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () async {
              // Add a new hotel
              await HotelService().addHotel(dummyHotels[0]);
            },
            child: const Text('Add Hotel'),
          ),
        ],
      ),
    );
  }
}
