import 'package:cloud_firestore/cloud_firestore.dart';

class Hotel {
  final String name;
  final String location;
  final String imageUrl;
  final double rating;
  final List<Room> rooms;

  Hotel({
    required this.name,
    required this.location,
    required this.imageUrl,
    required this.rating,
    required this.rooms,
  });

  // Convert Firestore document snapshot to Hotel object
  factory Hotel.fromSnapshot(DocumentSnapshot snapshot) {
    var data = snapshot.data() as Map<String, dynamic>;
    return Hotel(
      name: data['name'],
      location: data['location'],
      imageUrl: data['imageUrl'],
      rating: data['rating'].toDouble(),
      rooms: List<Room>.from((data['rooms'] as List).map((roomData) => Room.fromMap(roomData))),
    );
  }
}

class Room {
  final String name;
  final String description;

  Room({required this.name, required this.description});

  factory Room.fromMap(Map<String, dynamic> map) {
    return Room(
      name: map['name'],
      description: map['description'],
    );
  }
}