

class UserModel {
  String? uid;
  String? email;
  String? name;
  String? photoURL;

  UserModel({
    required this.uid,
    required this.email,
    required this.name,
    this.photoURL, required String firstname, required String lastname, 
  });
//serialize data to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': uid,
      'email': email,
      'displayName': name,
      'photoURL': photoURL,
    };
  }

//Deserialize JSON data to object received from cloud firestore
  factory UserModel.fromJson(Map<String, dynamic> json) {
  
    return UserModel(
      uid: json['id'],
      email: json['email'],
      name: json['displayName'],
      photoURL: json['photoURL'], firstname: '', lastname: '',  
    );
  }
}