// lib/models/verse_model.dart
class VerseModel {
  final int id;
  final int themeId;
  final String surah;
  final int ayah;
  final int juz;
  final String arabic;
  final String translation;
  final String tafsir;

  VerseModel({
    required this.id,
    required this.themeId,
    required this.surah,
    required this.ayah,
    required this.juz,
    required this.arabic,
    required this.translation,
    required this.tafsir,
  });

  factory VerseModel.fromJson(Map<String, dynamic> json) {
    return VerseModel(
      id: json['id'] is int ? json['id'] : int.parse('${json['id']}'),
      themeId: json['themeId'] is int ? json['themeId'] : int.parse('${json['themeId']}'),
      surah: json['surah'] ?? '',
      ayah: json['ayah'] is int ? json['ayah'] : int.parse('${json['ayah']}'),
      juz: json['juz'] is int ? json['juz'] : int.parse('${json['juz']}'),
      arabic: json['arabic'] ?? '',
      translation: json['translation'] ?? '',
      tafsir: json['tafsir'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'themeId': themeId,
        'surah': surah,
        'ayah': ayah,
        'juz': juz,
        'arabic': arabic,
        'translation': translation,
        'tafsir': tafsir,
      };

  @override
  String toString() => 'VerseModel($surah:$ayah)';
}
