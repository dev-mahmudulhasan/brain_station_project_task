// lib/models/repository.dart
class Repository {
  final String name;
  final int stargazersCount;
  final String owner;
  final String description;
  final String lastUpdated;

  Repository({
    required this.name,
    required this.stargazersCount,
    required this.owner,
    required this.description,
    required this.lastUpdated,
  });

  factory Repository.fromJson(Map<String, dynamic> json) {
    return Repository(
      name: json['name'],
      stargazersCount: json['stargazers_count'],
      owner: json['owner']['login'],
      description: json['description'] ?? 'No description',
      lastUpdated: json['updated_at'],
    );
  }
}
