class SignedTransaction {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;

  SignedTransaction.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        createdAt = DateTime.parse(json['attributes']['createdAt']),
        updatedAt = DateTime.parse(json['attributes']['updatedAt']);

  Map<String, dynamic> toJson() => {
        'type': 'signed-transaction',
        'id': id,
        'attributes': {
          'createdAt': createdAt.toIso8601String(),
          'updatedAt': updatedAt.toIso8601String(),
        }
      };
}
