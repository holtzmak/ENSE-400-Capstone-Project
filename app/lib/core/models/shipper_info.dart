import 'package:flutter/material.dart';

import 'address.dart';

@immutable
class ShipperInfo {
  final String shipperName;
  final bool shipperIsAnimalOwner;
  final String departureLocationId;
  final String departureLocationName;
  final Address departureAddress;
  final String shipperContactInfo;

  ShipperInfo(
      {@required this.shipperName,
      @required this.shipperIsAnimalOwner,
      @required this.departureLocationId,
      @required this.departureLocationName,
      @required this.departureAddress,
      @required this.shipperContactInfo});

  Widget toWidget() {
    return Column(children: [
      ListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -2),
          title: Text("Name"),
          subtitle: Text(shipperName)),
      ListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -2),
          title: Text(
              "The shipper is the owner of the animals loaded in the vehicle"),
          subtitle: Text('${shipperIsAnimalOwner ? 'Yes' : 'No'}')),
      ListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -2),
          title: Text("Departure Premises Identification number (PID)"),
          subtitle: Text(departureLocationId)),
      ListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -2),
          title: Text("Name"),
          subtitle: Text(departureLocationName)),
      ListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -2),
          title: Text("Address"),
          subtitle: Text('$departureAddress')),
      ListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -2),
          title: Text("Shipper’s Contact information in case of emergency"),
          subtitle: Text(shipperContactInfo)),
    ]);
  }
}
