
class User{
  final String nickName;
  final String firstName;
  final String lastName;
  final String password;

  const User({
    required this.nickName,
    required this.firstName,
    required this.lastName,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'nickName': this.nickName,
      'firstName': this.firstName,
      'lastName': this.lastName,
      'password': this.password,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      nickName: map['nickName'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      password: map['password'] as String,
    );
  }

  @override
  String toString() {
    return 'User{nickName: $nickName, firstName: $firstName, lastName: $lastName, password: $password}';
  }
}