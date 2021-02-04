import 'package:app/core/models/test_history.dart';
import 'package:app/core/services/firestore/firestore_service.dart';
import 'package:app/core/services/navigation/nav_service.dart';
import 'package:app/core/services/service_locator.dart';
import 'package:app/core/view_models/base_view_model.dart';
import 'package:flutter/material.dart';

class AddHistoryViewModel extends BaseViewModel {
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final NavigationService _navigationService = locator<NavigationService>();

  HistoryRecord _edittingHistory;
  bool get _isEditting => _edittingHistory != null;

  Future addHistory({@required String title}) async {
    setBusy(true);
    var result;

    if (!_isEditting) {
      result = await _firestoreService.addHistory(HistoryRecord(
        title: title,
        userId: currentUser.userId,
      ));
    } else {
      result = await _firestoreService.updatHistoryTravel(HistoryRecord(
          title: title,
          userId: _edittingHistory.userId,
          documentId: _edittingHistory.documentId));
    }

    setBusy(false);

    // If result is type String, then something went wrong
    if (result is String) {
      print('Something went wrong');
    } else {
      print('Sucessfully added ');
    }
    _navigationService.pop();
  }

  void setEdittingHistory(HistoryRecord historyRecord) {
    _edittingHistory = historyRecord;
  }
}
