class Calculation {
  final int? id;
  final int a;
  final int b;
  final int result;
  final String date;

  Calculation({
    this.id,
    required this.a,
    required this.b,
    required this.result,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'a': a,
      'b': b,
      'result': result,
      'date': date,
    };
  }

  factory Calculation.fromMap(Map<String, dynamic> map) {
    return Calculation(
      id: map['id'] as int,
      a: map['a'] as int,
      b: map['b'] as int,
      result: map['result'] as int,
      date: map['date'] as String,
    );
  }
}