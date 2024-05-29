import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_flutter_app/models/booking_model.dart';

class BookingService {
  final CollectionReference _bookingCollection = FirebaseFirestore.instance.collection('bookings');

  Future<void> addBooking(Booking booking) async {
    try {
      await _bookingCollection.add(booking.toMap());
    } catch (error) {
      print('Error adding booking: $error');
    }
  }

  Stream<List<Booking>> getBookingsForUser(String userId) {
    return _bookingCollection.where('userId', isEqualTo: userId).snapshots().map(
          (snapshot) => snapshot.docs.map((doc) => Booking.fromSnapshot(doc)).toList(),
        );
  }
}
