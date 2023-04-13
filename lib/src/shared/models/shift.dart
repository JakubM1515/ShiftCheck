import 'dart:convert';

class Shift {
  final String? id;
  final DateTime startTime;
  final DateTime endTime;
  final String title;
  final double moneyEarned;
  final String currency;
  final double salary;
  Shift({
    this.id,
    required this.startTime,
    required this.endTime,
    required this.title,
    required this.moneyEarned,
    required this.currency,
    required this.salary,
  });

  Shift copyWith({
    String? id,
    DateTime? startTime,
    DateTime? endTime,
    String? title,
    double? moneyEarned,
    String? currency,
    double? salary,
  }) {
    return Shift(
      id: id ?? this.id,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      title: title ?? this.title,
      moneyEarned: moneyEarned ?? this.moneyEarned,
      currency: currency ?? this.currency,
      salary: salary ?? this.salary,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'title': title,
      'moneyEarned': moneyEarned,
      'currency': currency,
      'salary': salary,
    };
  }

  factory Shift.fromMap(Map<String, dynamic> map) {
    return Shift(
      id: map['id'] as String,
      startTime: DateTime.parse(map['startTime']),
      endTime: DateTime.parse(map['endTime']),
      title: map['title'] as String,
      moneyEarned: map['moneyEarned'] as double,
      currency: map['currency'] as String,
      salary: map['salary'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory Shift.fromJson(String source) =>
      Shift.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Shift(id: $id, startTime: $startTime, endTime: $endTime, title: $title, moneyEarned: $moneyEarned, currency: $currency, salary: $salary)';
  }

  @override
  bool operator ==(covariant Shift other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.startTime == startTime &&
        other.endTime == endTime &&
        other.title == title &&
        other.moneyEarned == moneyEarned &&
        other.currency == currency &&
        other.salary == salary;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        startTime.hashCode ^
        endTime.hashCode ^
        title.hashCode ^
        moneyEarned.hashCode ^
        currency.hashCode ^
        salary.hashCode;
  }
}
