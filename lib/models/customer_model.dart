class Customer {
  int? id;
  String name;
  String mobile;
  String email;
  String address;
  double latitude;
  double longitude;
  String geoAddress;
  String image; // Image file path

  Customer({
    this.id,
    required this.name,
    required this.mobile,
    required this.email,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.geoAddress,
    required this.image,
  });

  // Convert a Customer object to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'mobile': mobile,
      'email': email,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'geoAddress': geoAddress,
      'image': image,
    };
  }

  // Create a Customer object from a Map
  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer(
      id: map['id'],
      name: map['name'],
      mobile: map['mobile'],
      email: map['email'],
      address: map['address'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      geoAddress: map['geoAddress'],
      image: map['image'],
    );
  }
}
