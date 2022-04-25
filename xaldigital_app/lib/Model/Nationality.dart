class Natyonality {
  final dynamic country;
  final dynamic name;

  const Natyonality({required this.country, required this.name});

  factory Natyonality.fromJson(Map<dynamic, dynamic> json) {
    return Natyonality(
      country: json['country'],
     
      name: json['name'],
    );
  }
}