// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../../shifts/domain/models/shift.dart';

class MonthSummary {
  final DateTime date;
  final List<Shift> shifts;
  MonthSummary({
    required this.date,
    required this.shifts,
  });


  MonthSummary copyWith({
    DateTime? date,
    List<Shift>? shifts,
  }) {
    return MonthSummary(
      date: date ?? this.date,
      shifts: shifts ?? this.shifts,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'date': date.toIso8601String(),
      'shifts': shifts.map((x) => x.toMap()).toList(),
    };
  }

  factory MonthSummary.fromMap(Map<String, dynamic> map) {
    return MonthSummary(
      date: DateTime.parse(map['date']),
      shifts: List<Shift>.from((map['shifts'] as List).map<Shift>((x) => Shift.fromMap(x as Map<String,dynamic>),),),
    );
  }

  String toJson() => json.encode(toMap());

  factory MonthSummary.fromJson(String source) => MonthSummary.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'MonthSummary(date: $date, shifts: $shifts)';

  @override
  bool operator ==(covariant MonthSummary other) {
    if (identical(this, other)) return true;
  
    return 
      other.date == date &&
      listEquals(other.shifts, shifts);
  }

  @override
  int get hashCode => date.hashCode ^ shifts.hashCode;
}
