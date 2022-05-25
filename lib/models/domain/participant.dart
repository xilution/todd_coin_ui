class Participant {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String email;
  final String? firstName;
  final String? lastName;
  final String? phone;
  final List<dynamic> roles;

  Participant.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        createdAt = DateTime.parse(json['attributes']['createdAt']),
        updatedAt = DateTime.parse(json['attributes']['updatedAt']),
        email = json['attributes']['email'],
        firstName = json['attributes']['firstName'],
        lastName = json['attributes']['lastName'],
        phone = json['attributes']['phone'],
        roles = json['attributes']['roles'];

  Map<String, dynamic> toJson() => {
        'type': 'participant',
        'id': id,
        'attributes': {
          'createdAt': createdAt.toIso8601String(),
          'updatedAt': updatedAt.toIso8601String(),
          'email': email,
          'firstName': firstName,
          'lastName': lastName,
          'phone': phone,
          'roles': roles,
        }
      };
}
