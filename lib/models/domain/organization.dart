class Organization {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;

  Organization(this.id, this.createdAt, this.updatedAt);

  Organization.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        createdAt = DateTime.parse(json['attributes']['createdAt']),
        updatedAt = DateTime.parse(json['attributes']['updatedAt']);

  Map<String, dynamic> toJson() => {
    'id': id,
    'attributes': {
    }
  };
}
