import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Hotel {
  final String name;
  final String location;
  final String imageUrl;
  final double rating;

  Hotel({
    required this.name,
    required this.location,
    required this.imageUrl,
    required this.rating,
  });

  // Convert Firestore document snapshot to Hotel object
  factory Hotel.fromSnapshot(DocumentSnapshot snapshot) {
    var data = snapshot.data() as Map<String, dynamic>;
    return Hotel(
      name: data['name'],
      location: data['location'],
      imageUrl: data['imageUrl'],
      rating: data['rating'].toDouble(),
    );
  }
}

class HotelService {
  Future<void> addHotelToFirestore(String id, Hotel hotel) async {
    try {
      await FirebaseFirestore.instance.collection('hotels').doc(id).set({
        'name': hotel.name,
        'location': hotel.location,
        'imageUrl': hotel.imageUrl,
        'rating': hotel.rating,
      });
    } catch (error) {
      print('Error adding hotel: $error');
    }
  }

  Stream<List<Hotel>> getHotelsFromFirestore() {
    return FirebaseFirestore.instance.collection('hotels').snapshots().map(
          (snapshot) => snapshot.docs.map((doc) => Hotel.fromSnapshot(doc)).toList(),
        );
  }
}

class AddHotelScreen extends StatefulWidget {
  final String hotelId;

  const  AddHotelScreen({super.key,  required this.hotelId});

  @override
  _AddHotelScreenState createState() => _AddHotelScreenState();
}

class _AddHotelScreenState extends State<AddHotelScreen> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final locationController = TextEditingController();
  final imageUrlController = TextEditingController();
  final ratingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const  Text('Add Hotel'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Hotel Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a hotel name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: locationController,
                decoration: const  InputDecoration(labelText: 'Location'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a location';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: imageUrlController,
                decoration: const  InputDecoration(labelText: 'Image URL'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an image URL';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: ratingController,
                keyboardType: TextInputType.number,
                decoration: const  InputDecoration(labelText: 'Rating'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a rating';
                  }
                  return null;
                },
              ),
              const  SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Create a new hotel object with the entered details
                    Hotel newHotel = Hotel(
                      name: nameController.text,
                      location: locationController.text,
                      imageUrl: imageUrlController.text,
                      rating: double.parse(ratingController.text),
                    );

                    // Add the new hotel to Firestore using the provided ID
                    HotelService().addHotelToFirestore(widget.hotelId, newHotel);

                    // Navigate back to the previous screen
                    Navigator.pop(context);
                  }
                },
                child: const  Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
          const SizedBox(height: 10.0),
          ElevatedButton(
            onPressed: () {
              // Generate a unique ID for the new hotel
              String hotelId = UniqueKey().toString();

              // Navigate to the AddHotelScreen and pass the generated ID
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddHotelScreen(hotelId: hotelId)),
              );
            },
            child: const Text('Add Hotel'),
          ),
        ],
      ),
    );
  }
}
