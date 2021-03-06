import 'package:flutter/foundation.dart';

class Transporter {
  final String firstName;
  final String lastName;
  final String userEmailAddress;
  final String userPhoneNumber;
  final String displayImageUrl;
  // The user ID should be the same as the current User of the app
  final String userId;
  final bool isAdmin;

  Transporter({
    @required this.firstName,
    @required this.lastName,
    @required this.userEmailAddress,
    @required this.userPhoneNumber,
    @required this.userId,
    @required this.isAdmin,
    this.displayImageUrl,
  });

  Transporter.fromJSON(Map<String, dynamic> json)
      : firstName = json['firstName'],
        lastName = json['lastName'],
        userEmailAddress = json['userEmailAddress'],
        userPhoneNumber = json['userPhoneNumber'],
        userId = json['userId'],
        displayImageUrl = json['displayImageUrl'],
        isAdmin = json['isAdmin'];

  Map<String, dynamic> toJSON() => {
        'firstName': firstName,
        'lastName': lastName,
        'userEmailAddress': userEmailAddress,
        'userPhoneNumber': userPhoneNumber,
        'userId': userId,
        'displayImageUrl': displayImageUrl,
        'isAdmin': isAdmin,
      };

  @override
  int get hashCode =>
      firstName.hashCode ^
      lastName.hashCode ^
      userEmailAddress.hashCode ^
      userPhoneNumber.hashCode ^
      isAdmin.hashCode ^
      displayImageUrl.hashCode ^
      userId.hashCode;

  @override
  bool operator ==(other) {
    return (other is Transporter) &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.userEmailAddress == userEmailAddress &&
        other.userPhoneNumber == userPhoneNumber &&
        other.userId == userId &&
        other.displayImageUrl == displayImageUrl &&
        other.isAdmin == isAdmin;
  }

  String toString() =>
      "Transporter(firstName: $firstName, lastName: $lastName, userEmailAddress: $userEmailAddress,, userPhoneNumber: $userPhoneNumber, userId: $userId, isAdmin: $isAdmin, displayImageUrl: $displayImageUrl)";
}
