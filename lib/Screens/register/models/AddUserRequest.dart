class AdduserRequest {
  final String name;
  final String email;

  AdduserRequest({required this.name, required this.email});

  // Convert a User object to a Map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
    };
  }

  // Create a User object from a Map
  factory AdduserRequest.fromMap(Map<String, dynamic> map) {
    return AdduserRequest(
      name: map['name'],
      email: map['email'],
    );
  }
}
