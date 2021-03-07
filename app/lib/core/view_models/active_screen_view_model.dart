import 'dart:async';

import 'package:app/core/models/animal_transport_record.dart';
import 'package:app/core/services/authentication/auth_service.dart';
import 'package:app/core/services/database/database_service.dart';
import 'package:app/core/services/dialog/dialog_service.dart';
import 'package:app/core/services/navigation/nav_service.dart';
import 'package:app/core/services/service_locator.dart';
import 'package:app/core/utilities/optional.dart';
import 'package:app/core/view_models/base_view_model.dart';
import 'package:app/ui/common/view_state.dart';
import 'package:app/ui/views/active/atr_editing_screen.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

/// This ViewModel will only view active ATR models
class ActiveScreenViewModel extends BaseViewModel {
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

  ActiveScreenViewModel() {
    final thisUser = _authenticationService.currentUser;
    if (thisUser.isPresent()) {
      _atrSubscription = _databaseService
          .getUpdatedActiveATRs(thisUser.get().uid)
          .listen((List<AnimalTransportRecord> atrs) {
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
        title: 'Launching the active screen failed',
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

  void navigateToActiveScreen() {
    _navigationService.pop();
  }

  void navigateToEditingScreen(AnimalTransportRecord atr) {
    _navigationService.navigateTo(ATREditingScreen.route, arguments: atr);
  }

  Future<void> saveEditedAtr(AnimalTransportRecord atr) async {
    setState(ViewState.Busy);
    return _databaseService
        .saveUpdatedAtr(atr)
        .then((_) => setState(ViewState.Idle))
        .catchError((e) {
      setState(ViewState.Idle);
      _dialogService.showDialog(
        title: 'Saving the Animal Transport Record failed',
        description: e.message,
      );
    });
  }

  Future<void> saveCompletedAtr(AnimalTransportRecord atr) async {
    setState(ViewState.Busy);
    saveEditedAtr(atr.asComplete())
        .then((_) => _dialogService.showDialog(
            title: "Animal Transport Form Submitted",
            description:
                '${DateFormat("yyyy-MM-dd hh:mm").format(DateTime.now())}'))
        .then((_) => setState(ViewState.Idle))
        .then((_) => _navigationService.pop())
        .catchError((e) {
      setState(ViewState.Idle);
      _dialogService.showDialog(
        title: 'Submission of the Animal Transport Record failed',
        description: e.message,
      );
    });
  }
}
