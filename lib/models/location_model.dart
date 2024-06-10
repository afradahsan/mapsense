class LocationModel{
  final int? id;
  final double latitude;
  final double longitude; 
  
  LocationModel({this.id, required this.latitude, required this.longitude,});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}