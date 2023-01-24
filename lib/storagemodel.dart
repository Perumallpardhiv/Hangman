class scoremodel {
  final int id;
  final int score;
  final DateTime date;

  scoremodel({
    required this.id,
    required this.score,
    required this.date,
  });

  Map<String, Object?> toMap() => {
        'id': id,
        'score': score,
        'date': date.toIso8601String(),
      };

  static scoremodel fromMap(Map<String, Object?> mp) => scoremodel(
        id: mp['id'] as int,
        score: mp['score'] as int,
        date: DateTime.parse(mp['date'] as String),
      );
}
