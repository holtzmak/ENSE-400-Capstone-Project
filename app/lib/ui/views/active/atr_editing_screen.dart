import 'package:app/core/models/animal_transport_record.dart';
import 'package:app/core/models/shipper_info.dart';
import 'package:app/core/services/dialog/dialog_service.dart';
import 'package:app/core/services/navigation/nav_service.dart';
import 'package:app/core/services/service_locator.dart';
import 'package:app/core/view_models/active_screen_view_model.dart';
import 'package:app/ui/views/active/form_field/shipper_info_form_field.dart';
import 'package:app/ui/widgets/models/expansion_list_item.dart';
import 'package:app/ui/widgets/utility/template_base_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ATREditingScreen extends StatefulWidget {
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();
  static const route = "/atrEditingScreen";
  final AnimalTransportRecord atr;

  ATREditingScreen({Key key, @required this.atr}) : super(key: key);

  @override
  _ATREditingScreenState createState() => _ATREditingScreenState();
}

class _ATREditingScreenState extends State<ATREditingScreen> {
  // Replacement ATR only used on submit
  AnimalTransportRecord _replacementAtr;

  ShipperInfoFormField _shipperInfoField;
  final List<ExpansionListItem> _atrFormFieldsWrapper = [];

  @override
  void initState() {
    super.initState();
    _replacementAtr = widget.atr;
    _shipperInfoField = ShipperInfoFormField(
        initialInfo: _replacementAtr.shipInfo,
        onSaved: (ShipperInfo newInfo) =>
            _replacementAtr = _replacementAtr.withShipInfo(newInfo));
    _atrFormFieldsWrapper.addAll([
      ExpansionListItem(
          expandedValue: _shipperInfoField,
          headerValue: _shipperInfoField.title)
    ]);
  }

  void _saveATR() {
    throw UnimplementedError(
        "TODO: Do WillPopScope = false, and force the user to use back button and save then");
  }

  void _submitATR() {
    // TODO: Call service and submit the completed atr
    widget._dialogService
        .showDialog(
            title: "Animal Transport Form Submitted",
            description:
                '${DateFormat("yyyy-MM-dd hh:mm").format(_replacementAtr.vehicleInfo.dateAndTimeLoaded)}',
            buttonText: "Ok")
        .then((_) => widget._navigationService.pop());
  }

  @override
  Widget build(BuildContext context) {
    return TemplateBaseViewModel<ActiveScreenViewModel>(
      builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            title: Text("Animal Transport Form"),
            automaticallyImplyLeading: false,
            leading: new IconButton(
              icon: new Icon(Icons.arrow_back_ios),
              onPressed: model.navigateToActiveScreen,
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                    child: buildExpansionPanelList(
                        expansionCallback: (int index, bool isExpanded) {
                          setState(() {
                            _atrFormFieldsWrapper[index].isExpanded =
                                !isExpanded;
                          });
                        },
                        items: _atrFormFieldsWrapper)),
                RaisedButton(
                  child: Text("Submit"),
                  onPressed: _submitATR,
                ),
              ],
            ),
          )),
    );
  }
}
