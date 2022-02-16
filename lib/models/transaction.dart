class Transactions {
  final double id;
  final String title;
  final double value;
  final int date;

  Transactions({
    required this.id,
    required this.title,
    required this.value,
    required this.date,
  });

  factory Transactions.fromMap(Map<String, dynamic> res) {
    return Transactions(
      id: res['id'],
      title: res['title'],
      value: res['value'],
      date: res['date'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'value': value,
      'date': date,
    };
  }
}
