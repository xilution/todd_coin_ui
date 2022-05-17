class ParticipantKey {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;

  ParticipantKey(this.id, this.createdAt, this.updatedAt);

  ParticipantKey.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        createdAt = DateTime.parse(json['attributes']['createdAt']),
        updatedAt = DateTime.parse(json['attributes']['updatedAt']);

  Map<String, dynamic> toJson() => {
    'id': id,
    'attributes': {
    }
  };
}
