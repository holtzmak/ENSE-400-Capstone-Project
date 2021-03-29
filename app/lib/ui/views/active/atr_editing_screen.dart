import 'package:app/core/models/animal_transport_record.dart';
import 'package:app/core/models/contingency_plan_info.dart';
import 'package:app/core/models/delivery_info.dart';
import 'package:app/core/models/feed_water_rest_info.dart';
import 'package:app/core/models/loading_vehicle_info.dart';
import 'package:app/core/models/shipper_info.dart';
import 'package:app/core/models/transporter_info.dart';
import 'package:app/core/services/dialog_service.dart';
import 'package:app/core/services/service_locator.dart';
import 'package:app/core/view_models/active_screen_view_model.dart';
import 'package:app/ui/common/style.dart';
import 'package:app/ui/common/view_state.dart';
import 'package:app/ui/views/active/form_field/acknowledgement_info_form_field.dart';
import 'package:app/ui/views/active/form_field/contingency_plan_info_form_field.dart';
import 'package:app/ui/views/active/form_field/delivery_info_form_field.dart';
import 'package:app/ui/views/active/form_field/fwr_info_form_field.dart';
import 'package:app/ui/views/active/form_field/loading_vehicle_info_form_field.dart';
import 'package:app/ui/views/active/form_field/shipper_info_form_field.dart';
import 'package:app/ui/views/active/form_field/transporter_info_form_field.dart';
import 'package:app/ui/widgets/models/expansion_list_item.dart';
import 'package:app/ui/widgets/utility/busy_overlay_screen.dart';
import 'package:app/ui/widgets/utility/template_base_view_model.dart';
import 'package:flutter/material.dart';

class ATREditingScreen extends StatefulWidget {
  static const route = "/atrEditingScreen";
  final DialogService _dialogService = locator<DialogService>();
  final AnimalTransportRecord atr;

  ATREditingScreen({Key key, @required this.atr}) : super(key: key);

  @override
  _ATREditingScreenState createState() => _ATREditingScreenState();
}

class _ATREditingScreenState extends State<ATREditingScreen> {
  AnimalTransportRecord _replacementAtr;
  AcknowledgementInfoImages _replacementImages;
  final List<ExpansionListItem> _atrFormFieldsWrapper = [];

  ShipperInfoFormField _shipperInfoField;
  TransporterInfoFormField _transporterInfoFormField;
  FeedWaterRestInfoFormField _feedWaterRestInfoFormField;
  LoadingVehicleInfoFormField _loadingVehicleInfoFormField;
  DeliveryInfoFormField _deliveryInfoFormField;
  AcknowledgementInfoFormField _acknowledgementInfoFormField;
  ContingencyPlanInfoFormField _contingencyPlanInfoFormField;

  @override
  void initState() {
    super.initState();
    _replacementAtr = widget.atr;
    _replacementImages = AcknowledgementInfoImages(
        shipperAck: widget.atr.ackInfo.shipperAck,
        transporterAck: widget.atr.ackInfo.transporterAck,
        receiverAck: widget.atr.ackInfo.receiverAck,
        shipperAckRecentImage: null,
        transporterAckRecentImage: null,
        receiverAckRecentImage: null);

    _shipperInfoField = ShipperInfoFormField(
        initialInfo: _replacementAtr.shipInfo,
        onSaved: (ShipperInfo newInfo) =>
            _replacementAtr = _replacementAtr.withShipInfo(newInfo));
    _transporterInfoFormField = TransporterInfoFormField(
        initialInfo: _replacementAtr.tranInfo,
        onSaved: (TransporterInfo newInfo) =>
            _replacementAtr = _replacementAtr.withTransporterInfo(newInfo));
    _feedWaterRestInfoFormField = FeedWaterRestInfoFormField(
        initialInfo: _replacementAtr.fwrInfo,
        onSaved: (FeedWaterRestInfo newInfo) =>
            _replacementAtr = _replacementAtr.withFwrInfo(newInfo));
    _loadingVehicleInfoFormField = LoadingVehicleInfoFormField(
        initialInfo: _replacementAtr.vehicleInfo,
        onSaved: (LoadingVehicleInfo newInfo) =>
            _replacementAtr = _replacementAtr.withVehicleInfo(newInfo));
    _deliveryInfoFormField = DeliveryInfoFormField(
      initialInfo: _replacementAtr.deliveryInfo,
      onSaved: (DeliveryInfo newInfo) =>
          _replacementAtr = _replacementAtr.withDeliveryInfo(newInfo),
    );
    _acknowledgementInfoFormField = AcknowledgementInfoFormField(
      initialInfo: _replacementAtr.ackInfo,
      onSaved: (AcknowledgementInfoImages newInfo) =>
          _replacementImages = newInfo,
    );
    _contingencyPlanInfoFormField = ContingencyPlanInfoFormField(
      initialInfo: _replacementAtr.contingencyInfo,
      onSaved: (ContingencyPlanInfo newInfo) =>
          _replacementAtr = _replacementAtr.withContingencyInfo(newInfo),
    );

    _atrFormFieldsWrapper.addAll([
      ExpansionListItem(
          expandedValue: _shipperInfoField,
          headerValue: _shipperInfoField.title),
      ExpansionListItem(
          expandedValue: _transporterInfoFormField,
          headerValue: _transporterInfoFormField.title),
      ExpansionListItem(
          expandedValue: _feedWaterRestInfoFormField,
          headerValue: _feedWaterRestInfoFormField.title),
      ExpansionListItem(
          expandedValue: _loadingVehicleInfoFormField,
          headerValue: _loadingVehicleInfoFormField.title),
      ExpansionListItem(
          expandedValue: _deliveryInfoFormField,
          headerValue: _deliveryInfoFormField.title),
      ExpansionListItem(
          expandedValue: _acknowledgementInfoFormField,
          headerValue: _acknowledgementInfoFormField.title),
      ExpansionListItem(
          expandedValue: _contingencyPlanInfoFormField,
          headerValue: _contingencyPlanInfoFormField.title)
    ]);
  }

  // TODO: #204. Determine which form was invalid and notify transporter
  bool _isFormValid() =>
      _shipperInfoField.validate() &&
      _transporterInfoFormField.validate() &&
      _feedWaterRestInfoFormField.validate() &&
      _loadingVehicleInfoFormField.validate() &&
      _deliveryInfoFormField.validate() &&
      _acknowledgementInfoFormField.validate() &&
      _contingencyPlanInfoFormField.validate();

  Future<bool> _isFormValidAndSaved() {
    if (_isFormValid()) {
      _saveForm();
      return Future.value(true);
    }
    return Future.error(false);
  }

  void _saveForm() {
    _shipperInfoField.save();
    _transporterInfoFormField.save();
    _feedWaterRestInfoFormField.save();
    _loadingVehicleInfoFormField.save();
    _deliveryInfoFormField.save();
    _acknowledgementInfoFormField.save();
    _contingencyPlanInfoFormField.save();
  }

  Future<bool> _saveBeforeWillPop(ActiveScreenViewModel model) async {
    _saveForm();
    return model
        .saveEditedAtr(_replacementAtr, _replacementImages)
        .then((_) => true)
        .catchError((e) => false);
  }

  Future<void> _saveAndNavigateBack(ActiveScreenViewModel model) async {
    _saveForm();
    return model
        .saveEditedAtr(_replacementAtr, _replacementImages)
        .then((_) => model.navigateBack())
        .catchError((e) => widget._dialogService.showDialog(
              title: 'Saving the Animal Transport Record failed',
              description: e.message,
            ));
  }

  Future<void> _submitATR(ActiveScreenViewModel model) async =>
      _isFormValidAndSaved()
          .then((_) =>
              model.saveCompletedAtr(_replacementAtr, _replacementImages))
          .catchError((_) => widget._dialogService.showDialog(
              title: 'Submission of the Animal Transport Record failed',
              description: 'One or more the the form fields is invalid'));

  @override
  Widget build(BuildContext context) {
    return TemplateBaseViewModel<ActiveScreenViewModel>(
        builder: (context, model, child) => WillPopScope(
              onWillPop: () => _saveBeforeWillPop(model),
              child: BusyOverlayScreen(
                show: model.state == ViewState.Busy,
                child: Scaffold(
                    backgroundColor: Beige,
                    appBar: AppBar(
                      title: Text(
                        "Animal Transport Form",
                        style: TextStyle(
                            color: NavyBlue, fontWeight: FontWeight.bold),
                      ),
                      actions: [
                        IconButton(
                            icon: Icon(Icons.delete),
                            color: NavyBlue,
                            onPressed: () => showDialog(
                                context: context,
                                child: AlertDialog(
                                  title: Text(
                                    'Confirm Delete',
                                    style: DialogBoxTitleStyle,
                                  ),
                                  content: Text(
                                      'Are you sure you want to delete this record?',
                                      style: DialogBoxContentStyle),
                                  actions: [
                                    FlatButton(
                                      child: Text(
                                        'Cancel',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      onPressed: () => Navigator.of(context,
                                              rootNavigator: true)
                                          .pop(),
                                    ),
                                    FlatButton(
                                        child: Text(
                                          'Confirm',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context,
                                                  rootNavigator: true)
                                              .pop();
                                          model.deleteActiveAtr(widget.atr);
                                        }),
                                  ],
                                )))
                      ],
                      backgroundColor: White,
                      automaticallyImplyLeading: false,
                      leading: new IconButton(
                          color: NavyBlue,
                          icon: new Icon(Icons.arrow_back),
                          onPressed: () async => _saveAndNavigateBack(model)),
                    ),
                    body: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                              child: buildExpansionPanelList(
                                  expansionCallback:
                                      (int index, bool isExpanded) {
                                    setState(() {
                                      _atrFormFieldsWrapper[index].isExpanded =
                                          !isExpanded;
                                    });
                                  },
                                  items: _atrFormFieldsWrapper)),
                          Padding(
                            padding: EdgeInsets.all(20),
                          ),
                          SizedBox(
                              height: 42,
                              width: 200,
                              child: RaisedButton(
                                child: Text("Submit",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: MediumTextSize)),
                                onPressed: () async => _submitATR(model),
                              )),
                        ],
                      ),
                    )),
              ),
            ));
  }
}
