import 'package:flutter/material.dart';
import 'package:my_flutter_app/hotel.dart';

class RoomListScreen extends StatelessWidget {
  final Hotel hotel;

  const RoomListScreen({super.key, required this.hotel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(hotel.name),
      ),
      body: ListView.builder(
        itemCount: hotel.rooms.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(hotel.rooms[index].name),
            subtitle: Text(hotel.rooms[index].description),
          );
        },
      ),
    );
  }
}