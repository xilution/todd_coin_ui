class Organization {
  final String name;

  Organization(this.name);

  Organization.fromJson(Map<String, dynamic> json)
      : name = json['name'];

  Map<String, dynamic> toJson() => {
    'name': name,
  };
}