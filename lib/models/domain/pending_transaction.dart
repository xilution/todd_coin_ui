class PendingTransaction {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;

  PendingTransaction(this.id, this.createdAt, this.updatedAt);

  PendingTransaction.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        createdAt = DateTime.parse(json['attributes']['createdAt']),
        updatedAt = DateTime.parse(json['attributes']['updatedAt']);

  Map<String, dynamic> toJson() => {'id': id, 'attributes': {}};
}
