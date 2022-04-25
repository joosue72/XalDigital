
class HistoySearch {
  final int? id;
  final String name;

  HistoySearch({this.id, required this.name});

  factory HistoySearch.fromMap(Map<String, dynamic> json) => HistoySearch(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
    };
  }
}
