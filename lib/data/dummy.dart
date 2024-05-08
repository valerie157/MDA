
import '../models/hotel_model.dart';
import '../models/room_model.dart';

List<Hotel> dummyHotels = [
  Hotel(
    id: "1",
    name: 'Grand Hyatt',
    location: 'New York, USA',
    rating: 4.8,
    imageUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQd25hKKL2-ygJb-k8j99bXTEQ19OY-agfgq6n1UKTIAQ&s',    rooms: [
      Room(type: 'Standard', rate: 150.0, isAvailable: true),
      Room(type: 'Deluxe', rate: 250.0, isAvailable: false),
      Room(type: 'Suite', rate: 400.0, isAvailable: true),
    ],
  ),
  Hotel(
    id: "2",
    name: 'Ritz-Carlton',
    location: 'Dubai, UAE',
    rating: 4.9,
    imageUrl:
        'https://fastly.picsum.photos/id/866/200/300.jpg?hmac=rcadCENKh4rD6MAp6V_ma-AyWv641M4iiOpe1RyFHeI',
    rooms: [
      Room(type: 'Classic', rate: 300.0, isAvailable: true),
      Room(type: 'Executive', rate: 450.0, isAvailable: true),
      Room(type: 'Presidential', rate: 800.0, isAvailable: false),
    ],
  ),
  Hotel(
    id: "2",
    name: 'Ritz-Carlton',
    location: 'Dubai, UAE',
    rating: 4.9,
    imageUrl:
        'https://fastly.picsum.photos/id/866/200/300.jpg?hmac=rcadCENKh4rD6MAp6V_ma-AyWv641M4iiOpe1RyFHeI',
    rooms: [
      Room(type: 'Classic', rate: 300.0, isAvailable: true),
      Room(type: 'Executive', rate: 450.0, isAvailable: true),
      Room(type: 'Presidential', rate: 800.0, isAvailable: false),
    ],
  ),
];
