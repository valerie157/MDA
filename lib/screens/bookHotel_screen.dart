import 'package:flutter/material.dart';
import 'package:my_flutter_app/domain/models/services/booking-service.dart';
import 'package:my_flutter_app/models/booking_model.dart';

class BookHotelScreen extends StatefulWidget {
  final String hotelId;
  final String userId;

  const BookHotelScreen({
    required this.hotelId,
    required this.userId,
    Key? key,
  }) : super(key: key);

  @override
  _BookHotelScreenState createState() => _BookHotelScreenState();
}

class _BookHotelScreenState extends State<BookHotelScreen> {
  final _formKey = GlobalKey<FormState>();
  final checkInController = TextEditingController();
  final checkOutController = TextEditingController();
  DateTime? checkInDate;
  DateTime? checkOutDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Hotel'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: checkInController,
                decoration: const InputDecoration(labelText: 'Check-In Date'),
                readOnly: true,
                onTap: () async {
                  DateTime? date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2101),
                  );
                  if (date != null) {
                    setState(() {
                      checkInDate = date;
                      checkInController.text = date.toLocal().toString().split(' ')[0];
                    });
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a check-in date';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: checkOutController,
                decoration: const InputDecoration(labelText: 'Check-Out Date'),
                readOnly: true,
                onTap: () async {
                  DateTime? date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now().add(const Duration(days: 1)),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2101),
                  );
                  if (date != null) {
                    setState(() {
                      checkOutDate = date;
                      checkOutController.text = date.toLocal().toString().split(' ')[0];
                    });
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a check-out date';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate() && checkInDate != null && checkOutDate != null) {
                    Booking newBooking = Booking(
                      userId: widget.userId,
                      hotelId: widget.hotelId,
                      checkInDate: checkInDate!,
                      checkOutDate: checkOutDate!,
                    );

                    BookingService().addBooking(newBooking);

                    Navigator.pop(context);
                  }
                },
                child: const Text('Book'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
