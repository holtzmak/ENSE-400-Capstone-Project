import 'package:app/core/models/loading_vehicle_info.dart';
import 'package:app/core/services/service_locator.dart';
import 'package:app/core/services/validation_service.dart';
import 'package:app/ui/common/style.dart';
import 'package:app/ui/views/active/dynamic_form_field/dynamic_animal_group_form_field.dart';
import 'package:app/ui/views/active/dynamic_form_field/dynamic_form_field.dart';
import 'package:app/ui/views/active/form_field/int_form_field.dart';
import 'package:app/ui/widgets/utility/date_time_picker.dart';
import 'package:flutter/material.dart';

class LoadingVehicleInfoFormField extends StatefulWidget {
  final ValidationService _validator = locator<ValidationService>();
  final Function(LoadingVehicleInfo info) onSaved;
  final LoadingVehicleInfo initialInfo;
  final String title = "Loading Vehicle Information";
  final _innerFormKey = GlobalKey<FormState>();

  void save() => _innerFormKey.currentState.save();

  // This function does not change the state of the widget
  // Must call validate within widget for error text to appear
  bool validate() => _innerFormKey.currentState.validate();

  LoadingVehicleInfoFormField(
      {Key key, @required this.initialInfo, @required this.onSaved})
      : super(key: key);

  @override
  _LoadingVehicleInfoFormFieldState createState() =>
      _LoadingVehicleInfoFormFieldState();
}

class _LoadingVehicleInfoFormFieldState
    extends State<LoadingVehicleInfoFormField> {
  DateTime _dateAndTimeLoaded;
  int _loadingArea;
  int _loadingDensity;
  int _animalsPerLoadingArea;
  List<AnimalGroup> _animalsLoaded;

  DynamicFormField<AnimalGroup> _animalsLoadedFormField;

  @override
  void initState() {
    _dateAndTimeLoaded = widget.initialInfo.dateAndTimeLoaded;
    _loadingArea = widget.initialInfo.loadingArea;
    _loadingDensity = widget.initialInfo.loadingDensity;
    _animalsPerLoadingArea = widget.initialInfo.animalsPerLoadingArea;
    _animalsLoaded = widget.initialInfo.animalsLoaded;
    _animalsLoadedFormField = dynamicAnimalGroupFormField(
        canBeEmpty: false,
        initialList: _animalsLoaded,
        onSaved: (List<AnimalGroup> changed) {
          _animalsLoaded = changed;
          _saveAll();
        });
    super.initState();
  }

  // As the forms are nested, they need to be told to save
  // Only one call to saved them is needed as this form's fields are saved together
  void _saveNestedForms() => _animalsLoadedFormField.save();

  // The nested save is blocked by validate so we save then validate,
  // validation must be true before submission so this is fine
  bool _saveAndValidateNestedForms() {
    _saveNestedForms();
    return _animalsLoadedFormField.validate();
  }

  void _saveAll() => widget.onSaved(LoadingVehicleInfo(
      dateAndTimeLoaded: _dateAndTimeLoaded,
      loadingArea: _loadingArea,
      loadingDensity: _loadingDensity,
      animalsPerLoadingArea: _animalsPerLoadingArea,
      animalsLoaded: _animalsLoaded));

  void _validateAndSaveAll() {
    // Do not short-circuit the validation calls using &&
    final isFormValid = widget._innerFormKey.currentState.validate();
    final isInnerFormValid = _animalsLoadedFormField.validate();
    if (isFormValid && isInnerFormValid) widget.save();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget._innerFormKey,
      child: Column(children: [
        outlinedTextContainer(
            textColor: White,
            borderColor: NavyBlue,
            backgroundColor: NavyBlue,
            text:
                "The loading vehicle information is to be filled out before the start of a transporter journey and should list the animals loaded and if any animals are compromised or have special needs"),
        ListTile(
            title: outlinedTextContainer(
                textColor: White,
                borderColor: NavyBlue,
                backgroundColor: NavyBlue,
                text: "Date and time of loading"),
            subtitle: dateTimePicker(
                initialDate: _dateAndTimeLoaded,
                onSaved: (String changed) {
                  _dateAndTimeLoaded = DateTime.parse(changed);
                  _saveAll();
                })),
        IntFormField(
            initial: _loadingArea,
            title: "Floor or container area available to animals (m2 or ft2)",
            validator: (int it) => _saveAndValidateNestedForms()
                ? widget._validator.intFieldValidator(it)
                : "*Something is missing. Try the save button!",
            onSaved: (int changed) {
              _loadingArea = changed;
              _saveNestedForms();
              _saveAll();
            }),
        IntFormField(
            initial: _loadingDensity,
            title: "Loading density",
            onSaved: (int changed) {
              _loadingDensity = changed;
              _saveAll();
            }),
        IntFormField(
            initial: _animalsPerLoadingArea,
            title: "Animals per floor area (Kg/m2 or lbs/ft2)",
            onSaved: (int changed) {
              _animalsPerLoadingArea = changed;
              _saveAll();
            }),
        Divider(
          color: NavyBlue,
          thickness: 4.0,
        ),
        ListTile(
            title: Text(
          "Animals loaded",
          style: TextStyle(fontWeight: FontWeight.bold),
        )),
        _animalsLoadedFormField,
        RaisedButton(
            child: Text(
              "Save",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: _validateAndSaveAll)
      ]),
    );
  }
}
