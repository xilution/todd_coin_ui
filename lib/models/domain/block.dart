class Block {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int sequenceId;
  final int nonce;
  final String previousHash;
  final String hash;

  Block.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        createdAt = DateTime.parse(json['attributes']['createdAt']),
        updatedAt = DateTime.parse(json['attributes']['updatedAt']),
        sequenceId = json['attributes']['sequenceId'],
        nonce = json['attributes']['nonce'],
        previousHash = json['attributes']['previousHash'],
        hash = json['attributes']['hash'];

  Map<String, dynamic> toJson() => {
        'type': 'block',
        'id': id,
        'attributes': {
          'createdAt': createdAt.toIso8601String(),
          'updatedAt': updatedAt.toIso8601String(),
          'sequenceId': sequenceId,
          'nonce': nonce,
          'previousHash': previousHash,
          'hash': hash,
        }
      };
}
