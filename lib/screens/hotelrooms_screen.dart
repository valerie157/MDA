import 'package:flutter/material.dart';
import 'package:my_flutter_app/models/hotel_model.dart'; // Import the Hotel model; // Import the Room model
import 'package:my_flutter_app/screens/roomdetails_screen.dart'; // Import the RoomDetailsScreen

class HotelRoomsScreen extends StatelessWidget {
  final Hotel hotel; // Define a property to store the hotel data

  const HotelRoomsScreen({super.key, required this.hotel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${hotel.name} Rooms'), // Use the hotel name as the app bar title
      ),
      body: ListView.builder(
        itemCount: hotel.rooms.length,
        itemBuilder: (context, index) {
          final room = hotel.rooms[index]; // Get the room at the current index
          return ListTile(
            title: Text(room.type), // Display the room type as the title
            subtitle: Text('\$${room.rate.toStringAsFixed(2)}'), // Display the room rate as the subtitle
            onTap: () {
              // Navigate to the RoomDetailsScreen when a room is tapped
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RoomDetailsScreen(room: room),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
