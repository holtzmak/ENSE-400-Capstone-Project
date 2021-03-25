import 'dart:convert';

import 'package:app/core/models/animal_transport_record.dart';
import 'package:app/core/utilities/optional.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A service wrapping the device's Shared Preferences
/// Data may be persisted to disk asynchronously, and there is no guarantee
/// that writes will be persisted to disk after returning, so this plugin must
/// not be used for storing critical data.
class SharedPreferencesService {
  final SharedPreferences _sharedPreferences;

  SharedPreferencesService(this._sharedPreferences);

  Optional<AnimalTransportRecord> getDefaultAtr() {
    try {
      final atrMaybe = AnimalTransportRecord.fromJSON(
          jsonDecode(_sharedPreferences.getString("defaultAtr"),
              reviver: _decodeDateTimeIfNeeded),
          // No ATR Document ID for default ATR, set one later
          "");
      return Optional.of(atrMaybe);
    } catch (error) {
      print(error);
      return Optional.empty();
    }
  }

  void setAtrAsDefault(AnimalTransportRecord atr) =>
      _sharedPreferences.setString("defaultAtr",
          jsonEncode(atr.toJSON(), toEncodable: _encodeDateTimeIfNeeded));

  dynamic _decodeDateTimeIfNeeded(dynamic key, dynamic value) {
    try {
      // We decode for google's date format so we convert to that format
      return Timestamp.fromDate(DateTime.parse(value));
    } catch (_) {
      return value;
    }
  }

  dynamic _encodeDateTimeIfNeeded(dynamic item) {
    if (item is DateTime) {
      return item.toString();
    }
    return item;
  }
}
