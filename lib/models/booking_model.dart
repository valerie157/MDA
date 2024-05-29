import 'package:cloud_firestore/cloud_firestore.dart';

class Booking {
  final String userId;
  final String hotelId;
  final DateTime checkInDate;
  final DateTime checkOutDate;

  Booking({
    required this.userId,
    required this.hotelId,
    required this.checkInDate,
    required this.checkOutDate,
  });

  // Convert Booking object to Firestore document format
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'hotelId': hotelId,
      'checkInDate': checkInDate,
      'checkOutDate': checkOutDate,
    };
  }

  // Convert Firestore document to Booking object
  factory Booking.fromSnapshot(DocumentSnapshot snapshot) {
    var data = snapshot.data() as Map<String, dynamic>;
    return Booking(
      userId: data['userId'],
      hotelId: data['hotelId'],
      checkInDate: (data['checkInDate'] as Timestamp).toDate(),
      checkOutDate: (data['checkOutDate'] as Timestamp).toDate(),
    );
  }
}
