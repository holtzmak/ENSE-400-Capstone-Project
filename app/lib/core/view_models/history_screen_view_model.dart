import 'dart:async';

import 'package:app/core/models/animal_transport_record.dart';
import 'package:app/core/services/authentication/auth_service.dart';
import 'package:app/core/services/database/database_service.dart';
import 'package:app/core/services/dialog/dialog_service.dart';
import 'package:app/core/services/navigation/nav_service.dart';
import 'package:app/core/services/service_locator.dart';
import 'package:app/core/utilities/optional.dart';
import 'package:app/core/view_models/base_view_model.dart';
import 'package:app/ui/widgets/utility/pdf_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// This ViewModel will only view complete ATR models
class HistoryScreenViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final DatabaseService _databaseService = locator<DatabaseService>();
  final DialogService _dialogService = locator<DialogService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  StreamSubscription<Optional<User>> _currentUserSubscription;
  StreamSubscription<List<AnimalTransportRecord>> _atrSubscription;

  final List<AnimalTransportRecord> _animalTransportRecords = [];

  List<AnimalTransportRecord> get animalTransportRecords =>
      List.unmodifiable(_animalTransportRecords);

  HistoryScreenViewModel() {
    final thisUser = _authenticationService.currentUser;
    if (thisUser.isPresent()) {
      _atrSubscription = _databaseService
          .getUpdatedCompleteATRs(thisUser.get().uid)
          .listen((atrs) {
        removeAll();
        addAll(atrs);
      });
      _currentUserSubscription = _authenticationService.currentUserChanges
          .listen((Optional<User> user) {
        // User has logged out or is no longer authenticated, lock the ViewModel
        if (!user.isPresent()) _cancelAtrSubscription();
      });
    } else {
      _dialogService.showDialog(
        title: 'Launching the history screen failed',
        description: "You are not logged in!",
      );
    }
  }

  void _cancelAtrSubscription() {
    removeAll();
    if (_atrSubscription != null) _atrSubscription.cancel();
  }

  @mustCallSuper
  void dispose() {
    _cancelAtrSubscription();
    if (_currentUserSubscription != null) _currentUserSubscription.cancel();
    super.dispose();
  }

  void addAll(List<AnimalTransportRecord> atrs) {
    _animalTransportRecords.addAll(atrs);
    notifyListeners();
  }

  void removeAll() {
    _animalTransportRecords.clear();
    notifyListeners();
  }

  void navigateToPDFScreen() {
    _navigationService.navigateTo(PDFScreen.route);
  }

  void navigateToHistoryScreen() {
    _navigationService.pop();
  }
}
