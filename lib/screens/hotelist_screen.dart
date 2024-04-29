import 'package:flutter/material.dart';
import 'package:my_flutter_app/screens/hotelrooms_screen.dart'; // Import the HotelRoomsScreen

class HotelListScreen extends StatelessWidget {
  const HotelListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_typing_uninitialized_variables
    var hotels;
    return Scaffold(
      appBar: AppBar(
        // ignore: prefer_const_constructors
        title: Text('Hotel List'),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          childAspectRatio: 0.75,
        ),
        itemCount: hotels.length,
        itemBuilder: (context, index) {
          final hotel = hotels[index]; // Get the hotel at the current index
          return GestureDetector(
            onTap: () {
              // Navigate to the HotelRoomsScreen and pass the selected hotel as a parameter
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HotelRoomsScreen(hotel: hotel),
                ),
              );
            },
            child: Card(
              // Card content
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    hotel.imageUrl,
                    fit: BoxFit.cover,
                    height: 150,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          hotel.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          hotel.location,
                          style: const TextStyle(fontSize: 14.0),
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          'Rating: ${hotel.rating}',
                          style: const TextStyle(fontSize: 14.0),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
