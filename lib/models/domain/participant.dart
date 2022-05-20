class Participant {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String email;
  final String? firstName;
  final String? lastName;
  final String? phone;
  final List<dynamic> roles;

  Participant(this.id, this.createdAt, this.updatedAt, this.email,
      this.firstName, this.lastName, this.phone, this.roles);

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
          'email': email,
          'firstName': firstName,
          'lastName': lastName,
          'phone': phone,
          'roles': roles,
        }
      };
}
