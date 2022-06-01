class Organization {
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  String? name;
  List<dynamic>? roles;

  Organization(
      {this.id, this.createdAt, this.updatedAt, this.name, this.roles});

  Organization.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        createdAt = DateTime.parse(json['attributes']['createdAt']),
        updatedAt = DateTime.parse(json['attributes']['updatedAt']),
        name = json['attributes']['name'],
        roles = json['attributes']['roles'];

  Map<String, dynamic> toJson() {
    Map<String, dynamic> base = {
      'type': 'organization',
      'attributes': {
        'name': name,
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
    return Organization(
        id: id,
        createdAt: createdAt,
        updatedAt: updatedAt,
        name: name,
        roles: roles);
  }
}
