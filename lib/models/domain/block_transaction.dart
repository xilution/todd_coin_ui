class BlockTransaction {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;

  BlockTransaction.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        createdAt = DateTime.parse(json['attributes']['createdAt']),
        updatedAt = DateTime.parse(json['attributes']['updatedAt']);

  Map<String, dynamic> toJson() => {
        'type': 'block-transaction',
        'id': id,
        'attributes': {
          'createdAt': createdAt.toIso8601String(),
          'updatedAt': updatedAt.toIso8601String(),
        }
      };
}
