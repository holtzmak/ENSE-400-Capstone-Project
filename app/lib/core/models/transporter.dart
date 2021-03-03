class Transporter {
  final String firstName;
  final String lastName;
  final String userEmailAddress;
  final String userPhoneNumber;

  // The user ID should be the same as the current User of the app
  final String userId;
  final bool isAdmin;

  Transporter(
      {this.firstName,
      this.lastName,
      this.userEmailAddress,
      this.userPhoneNumber,
      this.userId,
      this.isAdmin});

  Transporter.fromJSON(Map<String, dynamic> json)
      : firstName = json['firstName'],
        lastName = json['lastName'],
        userEmailAddress = json['userEmailAddress'],
        userPhoneNumber = json['userPhoneNumber'],
        userId = json['userId'],
        isAdmin = json['isAdmin'];

  Map<String, dynamic> toJSON() => {
        'firstName': firstName,
        'lastName': lastName,
        'userEmailAddress': userEmailAddress,
        'userPhoneNumber': userPhoneNumber,
        'userId': userId,
        'isAdmin': isAdmin,
      };

  @override
  int get hashCode =>
      firstName.hashCode ^
      lastName.hashCode ^
      userEmailAddress.hashCode ^
      userPhoneNumber.hashCode ^
      isAdmin.hashCode ^
      userId.hashCode;

  @override
  bool operator ==(other) {
    return (other is Transporter) &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.userEmailAddress == userEmailAddress &&
        other.userPhoneNumber == userPhoneNumber &&
        other.userId == userId &&
        other.isAdmin == isAdmin;
  }
}
