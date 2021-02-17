import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'address.dart';

@immutable
class TransporterInfo {
  final String companyName;
  final Address companyAddress;
  final List<String> _driverNames;
  final String vehicleProvince;
  final String vehicleLicensePlate;
  final String trailerProvince;
  final String trailerLicensePlate;
  final DateTime dateLastCleaned;
  final Address addressLastCleanedAt;
  final bool driversAreBriefed;
  final bool driversHaveTraining;
  final String trainingType;
  final DateTime trainingExpiryDate;

  TransporterInfo(
      {@required this.companyName,
      @required this.companyAddress,
      @required List<String> driverNames,
      @required this.vehicleProvince,
      @required this.vehicleLicensePlate,
      @required this.trailerProvince,
      @required this.trailerLicensePlate,
      @required this.dateLastCleaned,
      @required this.addressLastCleanedAt,
      @required this.driversAreBriefed,
      @required this.driversHaveTraining,
      @required this.trainingType,
      @required this.trainingExpiryDate})
      : _driverNames = driverNames;

  List<String> driverNames() => List.unmodifiable(_driverNames);

  Widget toWidget() {
    return Column(children: [
      ListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -2),
          title: Text("Name of transporting company"),
          subtitle: Text(companyName)),
      ListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -2),
          title: Text("Address"),
          subtitle: Text('$companyAddress')),
      ListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -2),
          title: Text("Driver(s) name(s)"),
          subtitle: Text('${driverNames().join(",")}')),
      ListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -2),
          title: Text(
              "Province and License Plate number of the conveyance transporting the animals"),
          subtitle: Text('$vehicleProvince, $vehicleLicensePlate')),
      ListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -2),
          title: Text("(including trailer)"),
          subtitle: Text('$trailerProvince, $trailerProvince')),
      ListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -2),
          title: Text("Conveyance or container last cleaned and disinfected")),
      ListTile(
        visualDensity: VisualDensity(horizontal: 0, vertical: -2),
        title: Text("Date and time"),
        subtitle:
            Text('${DateFormat("yyyy-MM-dd hh:mm").format(dateLastCleaned)}'),
      ),
      ListTile(
        visualDensity: VisualDensity(horizontal: 0, vertical: -2),
        title: Text("Place"),
        subtitle: Text('$addressLastCleanedAt'),
      ),
      ListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -2),
          title: Text("Driver(s) have been briefed on the contingency plan?"),
          subtitle: Text('${driversAreBriefed ? 'Yes' : 'No'}')),
      ListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -2),
          title: Text("Driver(s) have received humane transport training?"),
          subtitle: Text('${driversHaveTraining ? 'Yes' : 'No'}')),
      ListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -2),
          title: Text("Training type and Expiry date"),
          subtitle: Text(
              '$trainingType, ${DateFormat("yyyy-MM-dd hh:mm").format(trainingExpiryDate)}')),
    ]);
  }
}
