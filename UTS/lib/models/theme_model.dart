// lib/models/theme_model.dart
class ThemeModel {
  final int id;
  final String name;
  final String description;

  ThemeModel({
    required this.id,
    required this.name,
    required this.description,
  });

  factory ThemeModel.fromJson(Map<String, dynamic> json) {
    return ThemeModel(
      id: json['id'] is int ? json['id'] : int.parse('${json['id']}'),
      name: json['name'] ?? '',
      description: json['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
      };

  @override
  String toString() => 'ThemeModel(id: $id, name: $name)';
}
