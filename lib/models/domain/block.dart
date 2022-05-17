class Block {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int sequenceId;
  final int nonce;
  final String previousHash;
  final String hash;

  Block(this.id, this.createdAt, this.updatedAt, this.sequenceId, this.nonce,
      this.previousHash, this.hash);

  Block.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        createdAt = DateTime.parse(json['attributes']['createdAt']),
        updatedAt = DateTime.parse(json['attributes']['updatedAt']),
        sequenceId = json['attributes']['sequenceId'],
        nonce = json['attributes']['nonce'],
        previousHash = json['attributes']['previousHash'],
        hash = json['attributes']['hash'];

  Map<String, dynamic> toJson() => {'id': id, 'attributes': {}};
}
