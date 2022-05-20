class BlockTransaction {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;

  BlockTransaction(this.id, this.createdAt, this.updatedAt);

  BlockTransaction.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        createdAt = DateTime.parse(json['attributes']['createdAt']),
        updatedAt = DateTime.parse(json['attributes']['updatedAt']);

  Map<String, dynamic> toJson() =>
      {'type': 'block-transaction', 'id': id, 'attributes': {}};
}
