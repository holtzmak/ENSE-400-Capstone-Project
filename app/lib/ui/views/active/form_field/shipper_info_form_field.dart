import 'package:app/core/models/shipper_info.dart';
import 'package:flutter/material.dart';

import 'address_form_field.dart';
import 'group_form_field.dart';

class ShipperInfoFormField extends GroupFormField<ShipperInfo> {
  final Function(ShipperInfo info) onSaved;
  final TextEditingController _nameController;
  final TextEditingController _isAnimalOwnerController;
  final TextEditingController _departureIdController;
  final TextEditingController _departureNameController;
  final AddressFormField _addressFormField;
  final TextEditingController _contactInfoController;

  ShipperInfoFormField(
      {Key key, @required ShipperInfo initialInfo, @required this.onSaved})
      : _nameController = TextEditingController(text: initialInfo.shipperName),
        _isAnimalOwnerController = TextEditingController(
            text: initialInfo.shipperIsAnimalOwner ? "Yes" : "No"),
        _departureIdController =
            TextEditingController(text: initialInfo.departureLocationId),
        _departureNameController =
            TextEditingController(text: initialInfo.departureLocationName),
        _addressFormField =
            AddressFormField(initialAddr: initialInfo.departureAddress),
        _contactInfoController =
            TextEditingController(text: initialInfo.shipperContactInfo),
        super(key: key, formName: "Shipper's Information");

  @override
  _ShipperInfoFormFieldState createState() => _ShipperInfoFormFieldState();

  @override
  void save() {
    onSaved(ShipperInfo(
        shipperName: _nameController.text,
        shipperIsAnimalOwner:
            _isAnimalOwnerController.text == "Yes" ? true : false,
        departureLocationId: _departureIdController.text,
        departureLocationName: _departureNameController.text,
        departureAddress: _addressFormField.getAddress(),
        shipperContactInfo: _contactInfoController.text));
  }
}

class _ShipperInfoFormFieldState extends State<ShipperInfoFormField> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ListTile(
          title: Text("Name"),
          subtitle: TextFormField(
            controller: widget._nameController,
          )),
      ListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -2),
          title: Text(
              "The shipper is the owner of the animals loaded in the vehicle?"),
          subtitle: DropdownButtonFormField(
            value: widget._isAnimalOwnerController.text,
            items: ["Yes", "No"]
                .map((label) => DropdownMenuItem(
                      child: Text(label),
                      value: label,
                    ))
                .toList(),
            onChanged: (String value) => setState(() {
              widget._isAnimalOwnerController.text = value;
            }),
          )),
      ListTile(
          title: Text("Departure Premises Identification number (PID)"),
          subtitle: TextFormField(
            controller: widget._departureIdController,
          )),
      ListTile(
          title: Text("Name"),
          subtitle: TextFormField(
            controller: widget._departureNameController,
          )),
      ListTile(title: Text("Address"), subtitle: widget._addressFormField),
      ListTile(
          title: Text("Shipper’s Contact information in case of emergency"),
          subtitle: TextFormField(
            controller: widget._contactInfoController,
          )),
      RaisedButton(child: Text("Save"), onPressed: widget.save)
    ]);
  }
}
