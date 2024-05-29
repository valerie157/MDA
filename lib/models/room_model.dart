import 'package:cloud_firestore/cloud_firestore.dart';

class Room {
  final String type;
  final double rate;
  final bool isAvailable;

  Room({
    required this.type,
    required this.rate,
    required this.isAvailable,
  });
  //serialize to JSON
  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'rate': rate,
      'isAvailable': isAvailable,
    };
  }

  //deserialize to data
  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      type: json['type'],
      rate: json['rate'],
      isAvailable: json['isAvailable'],
    );
  }

  String? get name => null;

  static fromSnapshot(QueryDocumentSnapshot<Object?> roomDoc) {}

  toMap() {}
}
