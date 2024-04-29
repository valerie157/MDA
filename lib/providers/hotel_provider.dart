
import 'package:flutter/material.dart';
import 'package:my_flutter_app/data/dummy.dart';
import 'package:my_flutter_app/models/hotel_model.dart';
import 'package:my_flutter_app/domain/models/services/hotel-service.dart';

class HotelProvider extends ChangeNotifier {
  final HotelService _hotelService = HotelService();
//initialize an empty list of hotels
  List<Hotel> _hotels = [];
  //getter for the hotels list
  List<Hotel> get hotels => _hotels;

  get hotel => null;
/*
**All the methods below are from the HotelService class
*/
  Future<void> fetchHotels() async {
    try {
      _hotels = await _hotelService.getHotels();
      notifyListeners();
    } catch (e) {
      debugPrint('Error fetching hotels: $e');
    }
  }

  Future<void> addHotel(Hotel hotel) async {
    try {
      await _hotelService.addHotel(hotel);
      _hotels.add(hotel);
      notifyListeners();
    } catch (e) {
      debugPrint('Error adding hotel: $e');
    }
  }

 

  Future<void> deleteHotel(Hotel hotel) async {
    try {
      await _hotelService.deleteHotel(hotel.id.toString());
      _hotels.removeWhere((h) => h.id == hotel.id);
      notifyListeners();
    } catch (e) {
      debugPrint('Error deleting hotel: $e');
    }
  }

  //call the setHotels method from the HotelService class
  Future<void> setHotels() async {
    try {
      await _hotelService.setHotels(dummyHotels);
      _hotels = dummyHotels;
      notifyListeners();
    } catch (e) {
      debugPrint('Error setting hotels: $e');
    }
  }
}
