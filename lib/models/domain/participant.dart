class Participant {
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  String? email;
  String? password;
  String? firstName;
  String? lastName;
  String? phone;
  List<dynamic>? roles;

  Participant(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.email,
      this.password,
      this.firstName,
      this.lastName,
      this.phone,
      this.roles});

  Participant.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        createdAt = json['attributes']['createdAt'] != null
            ? DateTime.parse(json['attributes']['createdAt'])
            : null,
        updatedAt = json['attributes']['updatedAt'] != null
            ? DateTime.parse(json['attributes']['updatedAt'])
            : null,
        email = json['attributes']['email'],
        password = json['attributes']['password'],
        firstName = json['attributes']['firstName'],
        lastName = json['attributes']['lastName'],
        phone = json['attributes']['phone'],
        roles = json['attributes']['roles'];

  Map<String, dynamic> toJson() {
    Map<String, dynamic> base = {
      'type': 'participant',
      'attributes': {
        'email': email,
        'password': password,
        'firstName': firstName,
        'lastName': lastName,
        'phone': phone,
        'roles': roles,
      }
    };

    if (id != null) {
      base.addAll({
        'id': id,
      });
    }

    return base;
  }

  copy() {
    return Participant(
        id: id,
        createdAt: createdAt,
        updatedAt: updatedAt,
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
        phone: phone,
        roles: roles);
  }
}
