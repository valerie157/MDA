import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_flutter_app/models/hotel_model.dart';
import 'package:my_flutter_app/models/room_model.dart';

class HotelService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get the hotels from the Firestore database
  Future<List<Hotel>> getHotels() async {
    QuerySnapshot snapshot = await _firestore.collection('hotels').get();
    return snapshot.docs
        .map((doc) => Hotel.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  // Add a new hotel to the Firestore database
  Future<void> addHotel(Hotel hotel) async {
    await _firestore.collection('hotels').add(hotel.toJson());
  }

  // Update a hotel in the Firestore database by passing the hotel object with a matching id
  Future<void> updateHotel(Hotel hotel) async {
    await _firestore
        .collection('hotels')
        .doc(hotel.id)
        .update(hotel.toJson());
  }

  // Delete a hotel from the Firestore database by passing the hotel id
  Future<void> deleteHotel(String hotelId) async {
    await _firestore.collection('hotels').doc(hotelId).delete();
  }

  // Set the hotels in the Firestore database by passing a list of hotels
  Future<void> setHotels(List<Hotel> hotels) async {
    // Clear existing data
    QuerySnapshot snapshot = await _firestore.collection('hotels').get();
    for (DocumentSnapshot doc in snapshot.docs) {
      await doc.reference.delete();
    }

    // Add dummy data
    for (Hotel hotel in hotels) {
      await _firestore.collection('hotels').add(hotel.toJson());
    }
  }

  // Book a hotel
  Future<void> bookHotel(String hotelId, String userId, DateTime checkInDate, DateTime checkOutDate) async {
    await _firestore.collection('bookings').add({
      'hotelId': hotelId,
      'userId': userId,
      'checkInDate': checkInDate,
      'checkOutDate': checkOutDate,
    });
  }

  // Add rooms to a hotel
  Future<void> addRoomsToHotel(String hotelId, List<Room> rooms) async {
    try {
      await _firestore.collection('hotels').doc(hotelId).update({
        'rooms': FieldValue.arrayUnion(rooms.map((room) => room.toMap()).toList()),
      });
    } catch (error) {
      print('Error adding rooms to hotel: $error');
    }
  }
}
