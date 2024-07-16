class StoreModel {
  final int id;
  final String name;
  final String description;
  final int stargazersCount;

  StoreModel(
      {required this.id,
      required this.name,
      required this.description,
      required this.stargazersCount});

  factory StoreModel.fromJson(Map<String, dynamic> json) {
    return StoreModel(
      id: json['id'] != null ? int.parse(json['id'].toString()) : 0,
      name: json['name'].toString(),
      description: (json['description'] ?? "").toString(),
      stargazersCount: json['stargazers_count'] != null
          ? int.parse(json['stargazers_count'].toString())
          : 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'stargazersCount': stargazersCount
    };
  }
}
