class AppUser {
  final String uid;
  final String email;
  final String name;
  AppUser({
    required this.uid,
    required this.email,
    required this.name,
  });

  AppUser copyWith({
    String? uid,
    String? email,
    String? name,
  }) {
    return AppUser(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      name: name ?? this.name,
    );
  }

  //* convert app user -> json format
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
    };
  }

  //* convert json -> app user format
  factory AppUser.toJson(Map<String, dynamic> jsonUser) {
    return AppUser(
      uid: jsonUser['uid'],
      email: jsonUser['email'],
      name: jsonUser['name'],
    );
  }
}
