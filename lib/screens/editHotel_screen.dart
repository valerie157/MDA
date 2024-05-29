import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Hotel {
  final String name;
  final String location;
  final String imageUrl;
  final double rating;
  final String id;

  Hotel({
    required this.name,
    required this.location,
    required this.imageUrl,
    required this.rating,
    required this.id,
  });

  // Convert Firestore document snapshot to Hotel object
  factory Hotel.fromSnapshot(DocumentSnapshot snapshot) {
    var data = snapshot.data() as Map<String, dynamic>;
    return Hotel(
      name: data['name'],
      location: data['location'],
      imageUrl: data['imageUrl'],
      rating: data['rating'].toDouble(),
      id: snapshot.id,
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

  Future<void> updateHotelInFirestore(String id, Hotel hotel) async {
    try {
      await FirebaseFirestore.instance.collection('hotels').doc(id).update({
        'name': hotel.name,
        'location': hotel.location,
        'imageUrl': hotel.imageUrl,
        'rating': hotel.rating,
      });
    } catch (error) {
      print('Error updating hotel: $error');
    }
  }

  Stream<List<Hotel>> getHotelsFromFirestore() {
    return FirebaseFirestore.instance.collection('hotels').snapshots().map(
          (snapshot) => snapshot.docs.map((doc) => Hotel.fromSnapshot(doc)).toList(),
        );
  }
}

class EditHotelScreen extends StatefulWidget {
  final String hotelId;
  final Hotel hotel;

  const EditHotelScreen({super.key, required this.hotelId, required this.hotel});

  @override
  // ignore: library_private_types_in_public_api
  _EditHotelScreenState createState() => _EditHotelScreenState();
}

class _EditHotelScreenState extends State<EditHotelScreen> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final locationController = TextEditingController();
  final imageUrlController = TextEditingController();
  final ratingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.hotel.name;
    locationController.text = widget.hotel.location;
    imageUrlController.text = widget.hotel.imageUrl;
    ratingController.text = widget.hotel.rating.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Hotel'),
        actions: [
          IconButton(
            icon: const Icon(Icons.update),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                Hotel updatedHotel = Hotel(
                  name: nameController.text,
                  location: locationController.text,
                  imageUrl: imageUrlController.text,
                  rating: double.parse(ratingController.text),
                  id: widget.hotelId,
                );
                HotelService().updateHotelInFirestore(widget.hotelId, updatedHotel);
                Navigator.pop(context);
              }
            },
          ),
        ],
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
                decoration: const InputDecoration(labelText: 'Location'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a location';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: imageUrlController,
                decoration: const InputDecoration(labelText: 'Image URL'),
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
                decoration: const InputDecoration(labelText: 'Rating'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a rating';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
