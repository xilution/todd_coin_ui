class Participant {
  final String email;
  final String firstName;

  Participant(this.email, this.firstName);

  Participant.fromJson(Map<String, dynamic> json)
      : email = json['email'],
        firstName = json['firstName'];

  Map<String, dynamic> toJson() => {
    'email': email,
    'firstName': firstName,
  };
}