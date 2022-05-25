class Organization {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String name;

  Organization.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        createdAt = DateTime.parse(json['attributes']['createdAt']),
        updatedAt = DateTime.parse(json['attributes']['updatedAt']),
        name = json['attributes']['name'];

  Map<String, dynamic> toJson() => {
        'type': 'organization',
        'id': id,
        'attributes': {
          'createdAt': createdAt.toIso8601String(),
          'updatedAt': updatedAt.toIso8601String(),
          'name': name,
        }
      };
}
