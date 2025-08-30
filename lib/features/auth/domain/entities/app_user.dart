class AppUser {
  final String uid;
  final String email;

    AppUser({
      required this.uid,
      required this.email,
    });
  Map<String, dynamic> toJson() => {
    'uid': uid,
    'email': email,
  };

  factory AppUser.fromJson(Map<String, dynamic> json) => AppUser(
    uid: json['uid'],
    email: json['email'],
  );

}