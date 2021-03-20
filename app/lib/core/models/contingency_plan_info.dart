import 'package:app/ui/common/style.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

@immutable
class ContingencyPlanInfo {
  final String goalStatement;
  final String communicationPlan;
  final List<String> _crisisContacts;
  final String expectedPrepProcess;
  final String standardAnimalMonitoring;
  final List<String> _potentialHazards;
  final List<String> _potentialSafetyActions;
  final List<ContingencyPlanEvent> _contingencyEvents;

  ContingencyPlanInfo(
      {@required this.goalStatement,
      @required this.communicationPlan,
      @required List<String> crisisContacts,
      @required this.expectedPrepProcess,
      @required this.standardAnimalMonitoring,
      @required List<String> potentialHazards,
      @required List<String> potentialSafetyActions,
      @required List<ContingencyPlanEvent> contingencyEvents})
      : _crisisContacts = crisisContacts,
        _potentialHazards = potentialHazards,
        _potentialSafetyActions = potentialSafetyActions,
        _contingencyEvents = contingencyEvents;

  factory ContingencyPlanInfo.defaultContingencyInfo() => ContingencyPlanInfo(
      goalStatement: "",
      communicationPlan: "",
      crisisContacts: [],
      expectedPrepProcess: "",
      standardAnimalMonitoring: "",
      potentialHazards: [],
      potentialSafetyActions: [],
      contingencyEvents: []);

  @override
  int get hashCode =>
      goalStatement.hashCode ^
      communicationPlan.hashCode ^
      _crisisContacts.hashCode ^
      expectedPrepProcess.hashCode ^
      standardAnimalMonitoring.hashCode ^
      _potentialHazards.hashCode ^
      _potentialSafetyActions.hashCode ^
      _contingencyEvents.hashCode;

  @override
  bool operator ==(other) {
    return (other is ContingencyPlanInfo) &&
        other.goalStatement == goalStatement &&
        other.communicationPlan == communicationPlan &&
        listEquals(other.crisisContacts, _crisisContacts) &&
        other.expectedPrepProcess == expectedPrepProcess &&
        other.standardAnimalMonitoring == standardAnimalMonitoring &&
        listEquals(other.potentialHazards, _potentialHazards) &&
        listEquals(other.potentialSafetyActions, _potentialSafetyActions) &&
        listEquals(other.contingencyEvents, _contingencyEvents);
  }

  ContingencyPlanInfo.fromJSON(Map<String, dynamic> json)
      : goalStatement = json['goalStatement'],
        communicationPlan = json['communicationPlan'],
        _crisisContacts = List.from(json['crisisContacts']),
        expectedPrepProcess = json['expectedPrepProcess'],
        standardAnimalMonitoring = json['standardAnimalMonitoring'],
        _potentialHazards = List.from(json['potentialHazards']),
        _potentialSafetyActions = List.from(json['potentialSafetyActions']),
        _contingencyEvents = json['contingencyEvents']
            .map<ContingencyPlanEvent>((contingencyEvent) =>
                ContingencyPlanEvent.fromJSON(contingencyEvent))
            .toList();

  Map<String, dynamic> toJSON() => {
        'goalStatement': goalStatement,
        'communicationPlan': communicationPlan,
        'crisisContacts': _crisisContacts,
        'expectedPrepProcess': expectedPrepProcess,
        'standardAnimalMonitoring': standardAnimalMonitoring,
        'potentialHazards': _potentialHazards,
        'potentialSafetyActions': _potentialSafetyActions,
        'contingencyEvents': _contingencyEvents
            .map((contingencyEvent) => contingencyEvent.toJSON())
            .toList()
      };

  List<String> get crisisContacts => List.unmodifiable(_crisisContacts);

  List<String> get potentialHazards => List.unmodifiable(_potentialHazards);

  List<String> get potentialSafetyActions =>
      List.unmodifiable(_potentialSafetyActions);

  List<ContingencyPlanEvent> get contingencyEvents =>
      List.unmodifiable(_contingencyEvents);

  String _contingencyEventsToString() => _contingencyEvents.isEmpty
      ? 'No events occurred during transport'
      : _contingencyEvents.map((event) => event.toString()).toList().join(",");

  String toString() =>
      '''Goal Statement (company’s goal and purpose of the plan i.e avoid animal suffering): $goalStatement
      Communication Plan (who should be contacted and who will initiate or permit the process?): $communicationPlan
      Crisis contacts and links (general helpline, industry related links and websites): ${_crisisContacts.join(',')}
      Expected Preparation Process (what should be done prior to loading animals?): $expectedPrepProcess
      Standard Animal Monitoring: $standardAnimalMonitoring
      Potential Hazard/Events/Challenges: ${_potentialHazards.join(',')}
      Potential Actions to Ensure Human or Animal Safety: ${_potentialSafetyActions.join(',')}
      Event Specific Plan(s): ${_contingencyEventsToString()}''';

  List<Widget> _contingencyEventsToWidget() => _contingencyEvents.isEmpty
      ? [
          ListTile(
              visualDensity: VisualDensity(horizontal: 0, vertical: -2),
              title: Text('No events occurred during transport'))
        ]
      : _contingencyEvents.map((event) => event.toWidget()).toList();

  Widget toWidget() {
    final List<Widget> fields = [
      ListTile(
          title: Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Text(
                  "Goal Statement (company’s goal and purpose of the plan i.e avoid animal suffering)")),
          subtitle: Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(border: Border.all(color: NavyBlue)),
              child: Text(goalStatement))),
      ListTile(
          title: Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Text(
                  "Communication Plan (who should be contacted and who will initiate or permit the process?)")),
          subtitle: Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(border: Border.all(color: NavyBlue)),
              child: Text(communicationPlan))),
      ListTile(
          title: Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Text(
                  "Crisis contacts and links( general helpline, industry related links and websites)")),
          subtitle: Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(border: Border.all(color: NavyBlue)),
              child: Text('${_crisisContacts.join(',')}'))),
      ListTile(
          title: Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Text(
                  "Expected Preparation Process (what should be done prior to loading animals?)")),
          subtitle: Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(border: Border.all(color: NavyBlue)),
              child: Text(expectedPrepProcess))),
      ListTile(
          title: Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Text("Standard Animal Monitoring")),
          subtitle: Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(border: Border.all(color: NavyBlue)),
              child: Text(standardAnimalMonitoring))),
      ListTile(
          title: Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Text("Potential Hazard/Events/Challenges")),
          subtitle: Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(border: Border.all(color: NavyBlue)),
              child: Text('${_potentialHazards.join(',')}'))),
      ListTile(
          title: Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child:
                  Text("Potential Actions to Ensure Human or Animal Safety")),
          subtitle: Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(border: Border.all(color: NavyBlue)),
              child: Text('${_potentialSafetyActions.join(',')}'))),
      ListTile(title: Text("Event Specific Plan(s)")),
    ];
    fields.addAll(_contingencyEventsToWidget());
    return Column(children: fields);
  }
}

@immutable
class ContingencyPlanEvent {
  final DateTime eventDateAndTime;
  final List<String> _producerContactsUsed;
  final List<String> _receiverContactsUsed;
  final String disturbancesIdentified;
  final List<ContingencyActivity> _activities;
  final List<String> _actionsTaken;

  ContingencyPlanEvent(
      {@required this.eventDateAndTime,
      @required List<String> producerContactsUsed,
      @required List<String> receiverContactsUsed,
      @required this.disturbancesIdentified,
      @required List<ContingencyActivity> activities,
      @required List<String> actionsTaken})
      : _producerContactsUsed = producerContactsUsed,
        _receiverContactsUsed = receiverContactsUsed,
        _activities = activities,
        _actionsTaken = actionsTaken;

  @override
  int get hashCode =>
      eventDateAndTime.hashCode ^
      _producerContactsUsed.hashCode ^
      _receiverContactsUsed.hashCode ^
      disturbancesIdentified.hashCode ^
      _activities.hashCode ^
      _actionsTaken.hashCode;

  @override
  bool operator ==(other) {
    return (other is ContingencyPlanEvent) &&
        other.eventDateAndTime == eventDateAndTime &&
        listEquals(other.producerContactsUsed, _producerContactsUsed) &&
        listEquals(other.receiverContactsUsed, _receiverContactsUsed) &&
        other.disturbancesIdentified == disturbancesIdentified &&
        listEquals(other.activities, activities) &&
        listEquals(other.actionsTaken, _actionsTaken);
  }

  ContingencyPlanEvent.fromJSON(Map<String, dynamic> json)
      : eventDateAndTime = json['eventDateAndTime'].toDate(),
        _producerContactsUsed = List.from(json['producerContactsUsed']),
        _receiverContactsUsed = List.from(json['receiverContactsUsed']),
        disturbancesIdentified = json['disturbancesIdentified'],
        _activities = json['activities']
            .map<ContingencyActivity>(
                (compAnimal) => ContingencyActivity.fromJSON(compAnimal))
            .toList(),
        _actionsTaken = List.from(json['actionsTaken']);

  Map<String, dynamic> toJSON() => {
        'eventDateAndTime': eventDateAndTime,
        'producerContactsUsed': _producerContactsUsed,
        'receiverContactsUsed': _receiverContactsUsed,
        'disturbancesIdentified': disturbancesIdentified,
        'activities': _activities.map((activity) => activity.toJSON()).toList(),
        'actionsTaken': _actionsTaken,
      };

  List<String> get producerContactsUsed =>
      List.unmodifiable(_producerContactsUsed);

  List<String> get receiverContactsUsed =>
      List.unmodifiable(_receiverContactsUsed);

  List<ContingencyActivity> get activities => List.unmodifiable(_activities);

  List<String> get actionsTaken => List.unmodifiable(_actionsTaken);

  String toString() =>
      '''Date and time of event: ${DateFormat("yyyy-MM-dd hh:mm").format(eventDateAndTime)}
      Producer's emergency contacts used: ${_producerContactsUsed.join(",")}
      Receiver's emergency contacts used: ${_receiverContactsUsed.join(",")}
      Disturbances identified: $disturbancesIdentified
      List of animal welfare related measures and actions taken(specific to the event): ${_actionsTaken.join(",")}
      Carrier's communication activities: ${_activities.map((activity) => activity.toString()).toList().join(',')}''';

  Widget toWidget() {
    final List<Widget> widgetFields = [
      ListTile(
          title: Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Text("Date and time of event")),
          subtitle: Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(border: Border.all(color: NavyBlue)),
              child: Text(
                  '${DateFormat("yyyy-MM-dd hh:mm").format(eventDateAndTime)}'))),
      ListTile(
          title: Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Text("Producer's emergency contacts used")),
          subtitle: Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(border: Border.all(color: NavyBlue)),
              child: Text('${_producerContactsUsed.join(",")}'))),
      ListTile(
          title: Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Text("Receiver's emergency contacts used")),
          subtitle: Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(border: Border.all(color: NavyBlue)),
              child: Text('${_receiverContactsUsed.join(",")}'))),
      ListTile(
          title: Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Text(
                  "Transportation challenges and disturbances identified by driver")),
          subtitle: Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(border: Border.all(color: NavyBlue)),
              child: Text(disturbancesIdentified))),
      ListTile(
          title: Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Text(
                  "List of animal welfare related measures and actions taken(specific to the event)")),
          subtitle: Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(border: Border.all(color: NavyBlue)),
              child: Text('${_actionsTaken.join(",")}'))),
      ListTile(title: Text("Carrier's communication activities")),
    ];
    widgetFields
        .addAll(_activities.map((activity) => activity.toWidget()).toList());
    return Column(children: widgetFields);
  }
}

@immutable
class ContingencyActivity {
  final DateTime time;
  final String personContacted;
  final String methodOfContact;
  final String instructionsGiven;

  ContingencyActivity(
      {@required this.time,
      @required this.personContacted,
      @required this.methodOfContact,
      @required this.instructionsGiven});

  @override
  int get hashCode =>
      time.hashCode ^
      personContacted.hashCode ^
      methodOfContact.hashCode ^
      instructionsGiven.hashCode;

  @override
  bool operator ==(other) {
    return (other is ContingencyActivity) &&
        DateFormat("hh:mm").format(other.time) ==
            DateFormat("hh:mm").format(time) &&
        other.personContacted == personContacted &&
        other.methodOfContact == methodOfContact &&
        other.instructionsGiven == instructionsGiven;
  }

  ContingencyActivity.fromJSON(Map<String, dynamic> json)
      : time = json['time'].toDate(),
        personContacted = json['personContacted'],
        methodOfContact = json['methodOfContact'],
        instructionsGiven = json['instructionsGiven'];

  Map<String, dynamic> toJSON() => {
        'time': time,
        'personContacted': personContacted,
        'methodOfContact': methodOfContact,
        'instructionsGiven': instructionsGiven,
      };

  String toString() =>
      '''Time of communication: ${DateFormat("hh:mm").format(time)}
  Who was contacted: $personContacted
  Communication method used: $methodOfContact
  What instructions were given and decisions made with the guidance of emergency contacts reached: $instructionsGiven''';

  Widget toWidget() {
    return Column(children: [
      ListTile(
          title: Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Text("Time of communication")),
          subtitle: Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(border: Border.all(color: NavyBlue)),
              child: Text('${DateFormat("hh:mm").format(time)}'))),
      ListTile(
          title: Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Text("Who was contacted")),
          subtitle: Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(border: Border.all(color: NavyBlue)),
              child: Text(personContacted))),
      ListTile(
          title: Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Text("Communication method used")),
          subtitle: Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(border: Border.all(color: NavyBlue)),
              child: Text(methodOfContact))),
      ListTile(
          title: Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Text(
                  "What instructions were given and decisions made with the guidance of emergency contacts reached")),
          subtitle: Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(border: Border.all(color: NavyBlue)),
              child: Text(instructionsGiven))),
      Padding(
        padding: EdgeInsets.only(bottom: 10.0),
      )
    ]);
  }
}
