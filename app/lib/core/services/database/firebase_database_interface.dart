import 'dart:async';

import 'package:app/core/models/animal_transport_record.dart';
import 'package:app/core/models/transporter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'database_interface.dart';

class FirebaseDatabaseInterface implements DatabaseInterface {
  final FirebaseFirestore _firestore;

  FirebaseDatabaseInterface(this._firestore);

  @override
  Future<void> setNewTransporter(Transporter newTransporter) async => _firestore
      .collection('transporter')
      .doc(newTransporter.userId)
      .set(newTransporter.toJSON());

  @override
  Future<Transporter> getTransporter(String userId) async =>
      _firestore.collection('transporter').doc(userId).get().then(
          (DocumentSnapshot snapshot) => Transporter.fromJSON(snapshot.data()));

  @override
  Future<void> removeTransporter(String userId) async =>
      _firestore.collection('transporter').doc(userId).delete();

  @override
  Future<AnimalTransportRecord> setNewAtr(String userId) async {
    final defaultAtrAsPlaceholder = AnimalTransportRecord.defaultAtr(userId);
    return _firestore
        .collection('atr')
        .add(defaultAtrAsPlaceholder.toJSON())
        .then((docRef) => defaultAtrAsPlaceholder.withDocId(docRef.id));
  }

  @override
  Future<void> updateAtr(AnimalTransportRecord atr) async => _firestore
      .collection('atr')
      .doc(atr.identifier.atrDocumentId)
      .update(atr.toJSON());

  @override
  Future<void> removeAtr(String atrDocumentId) async =>
      _firestore.collection('atr').doc(atrDocumentId).delete();

  @override
  Future<List<AnimalTransportRecord>> getCompleteRecords() async => _firestore
      .collection('atr')
      .where('identifier.isComplete', isEqualTo: true)
      .get()
      .then((snapshot) => snapshot.docs
          .map((doc) => AnimalTransportRecord.fromJSON(doc.data(), doc.id))
          .toList());

  @override
  Future<List<AnimalTransportRecord>> getActiveRecords() async => _firestore
      .collection('atr')
      .where('identifier.isComplete', isEqualTo: false)
      .get()
      .then((snapshot) => snapshot.docs
          .map((doc) => AnimalTransportRecord.fromJSON(doc.data(), doc.id))
          .toList());

  /// This returns the whole list of records in the database, not just updated ones
  @override
  Stream<List<AnimalTransportRecord>> getUpdatedCompleteATRs() => _firestore
      .collection('atr')
      .where('identifier.isComplete', isEqualTo: true)
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => AnimalTransportRecord.fromJSON(doc.data(), doc.id))
          .toList());

  /// This returns the whole list of records in the database, not just updated ones
  @override
  Stream<List<AnimalTransportRecord>> getUpdatedActiveATRs() => _firestore
      .collection('atr')
      .where('identifier.isComplete', isEqualTo: false)
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => AnimalTransportRecord.fromJSON(doc.data(), doc.id))
          .toList());
}
