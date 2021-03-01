import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

@immutable
class LoadingVehicleInfo {
  final DateTime dateAndTimeLoaded;
  final int loadingArea;
  final int loadingDensity;
  final int animalsPerLoadingArea;
  final List<AnimalGroup> _animalsLoaded;

  LoadingVehicleInfo(
      {@required this.dateAndTimeLoaded,
      @required this.loadingArea,
      @required this.loadingDensity,
      @required this.animalsPerLoadingArea,
      @required List<AnimalGroup> animalsLoaded})
      : _animalsLoaded = animalsLoaded;

  LoadingVehicleInfo.fromJSON(Map<String, dynamic> json)
      : dateAndTimeLoaded = json['dateAndTimeLoaded'].toDate(),
        loadingArea = json['loadingArea'],
        loadingDensity = json['loadingDensity'],
        animalsPerLoadingArea = json['animalsPerLoadingArea'],
        _animalsLoaded = json['_animalsLoaded']
            .map<AnimalGroup>(
                (animalLoaded) => AnimalGroup.fromJSON(animalLoaded))
            .toList();

  Map<String, dynamic> toJSON() => {
        'dateAndTimeLoaded': dateAndTimeLoaded,
        'loadingArea': loadingArea,
        'loadingDensity': loadingDensity,
        'animalsPerLoadingArea': animalsPerLoadingArea,
        '_animalsLoaded':
            _animalsLoaded.map((animalLoaded) => animalLoaded.toJSON()).toList()
      };

  @override
  int get hashCode =>
      dateAndTimeLoaded.hashCode ^
      loadingArea.hashCode ^
      loadingDensity.hashCode ^
      animalsPerLoadingArea.hashCode ^
      _animalsLoaded.hashCode;

  @override
  bool operator ==(other) {
    return (other is LoadingVehicleInfo) &&
        other.dateAndTimeLoaded == dateAndTimeLoaded &&
        other.loadingArea == loadingArea &&
        other.loadingDensity == loadingDensity &&
        other.animalsPerLoadingArea == animalsPerLoadingArea &&
        listEquals(other.animalsLoaded, _animalsLoaded);
  }

  List<AnimalGroup> get animalsLoaded => List.unmodifiable(_animalsLoaded);

  List<String> get animalSpeciesLoaded => List.unmodifiable(
      _animalsLoaded.map((animalGroup) => animalGroup.species).toList());

  String toString() =>
      '''Date and time of loading: ${DateFormat("yyyy-MM-dd hh:mm").format(dateAndTimeLoaded)}
      Floor or container area available to animals (m2 or ft2): $loadingArea
      Loading density: $loadingDensity
      Animals per floor area (Kg/m2 or lbs/ft2): $animalsPerLoadingArea
      Animals loaded: ${_animalsLoaded.map((group) => group.toString()).join('\n')}''';

  Widget toWidget() {
    final List<Widget> fields = [
      ListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -2),
          title: Text("Date and time of loading"),
          subtitle: Text(
              '${DateFormat("yyyy-MM-dd hh:mm").format(dateAndTimeLoaded)}')),
      ListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -2),
          title:
              Text("Floor or container area available to animals (m2 or ft2)"),
          subtitle: Text('$loadingArea')),
      ListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -2),
          title: Text("Loading density"),
          subtitle: Text('$loadingDensity')),
      ListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -2),
          title: Text("Animals per floor area (Kg/m2 or lbs/ft2)"),
          subtitle: Text('$animalsPerLoadingArea')),
      ListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -2),
          title: Text("Animals loaded")),
    ];
    fields.addAll(_animalsLoaded.map((group) => group.toWidget()).toList());
    return Column(children: fields);
  }
}

@immutable
class AnimalGroup {
  final String species;
  final int groupAge;
  final int approximateWeight;
  final String animalPurpose;
  final int numberAnimals;
  final bool animalsFitForTransport;
  final List<CompromisedAnimal> _compromisedAnimals;
  final List<CompromisedAnimal> _specialNeedsAnimals;

  AnimalGroup(
      {@required this.species,
      @required this.groupAge,
      @required this.approximateWeight,
      @required this.animalPurpose,
      @required this.numberAnimals,
      @required this.animalsFitForTransport,
      @required List<CompromisedAnimal> compromisedAnimals,
      @required List<CompromisedAnimal> specialNeedsAnimals})
      : _compromisedAnimals = compromisedAnimals,
        _specialNeedsAnimals = specialNeedsAnimals;

  @override
  int get hashCode =>
      species.hashCode ^
      groupAge.hashCode ^
      approximateWeight.hashCode ^
      animalPurpose.hashCode ^
      numberAnimals.hashCode ^
      animalsFitForTransport.hashCode ^
      _compromisedAnimals.hashCode ^
      _specialNeedsAnimals.hashCode;

  @override
  bool operator ==(other) {
    return (other is AnimalGroup) &&
        other.species == species &&
        other.groupAge == groupAge &&
        other.approximateWeight == approximateWeight &&
        other.animalPurpose == animalPurpose &&
        other.numberAnimals == numberAnimals &&
        other.animalsFitForTransport == animalsFitForTransport &&
        listEquals(other.compromisedAnimals, _compromisedAnimals) &&
        listEquals(other.specialNeedsAnimals, _specialNeedsAnimals);
  }

  AnimalGroup.fromJSON(Map<String, dynamic> json)
      : species = json['species'],
        groupAge = json['groupAge'],
        approximateWeight = json['approximateWeight'],
        animalPurpose = json['animalPurpose'],
        numberAnimals = json['numberAnimals'],
        animalsFitForTransport = json['animalsFitForTransport'],
        _compromisedAnimals = json['_compromisedAnimals']
            .map<CompromisedAnimal>(
                (compAnimal) => CompromisedAnimal.fromJSON(compAnimal))
            .toList(),
        _specialNeedsAnimals = json['_specialNeedsAnimals']
            .map<CompromisedAnimal>(
                (specialAnimal) => CompromisedAnimal.fromJSON(specialAnimal))
            .toList();

  Map<String, dynamic> toJSON() => {
        'species': species,
        'groupAge': groupAge,
        'approximateWeight': approximateWeight,
        'animalPurpose': animalPurpose,
        'numberAnimals': numberAnimals,
        'animalsFitForTransport': animalsFitForTransport,
        '_compromisedAnimals': _compromisedAnimals
            .map((compAnimal) => compAnimal.toJSON())
            .toList(),
        '_specialNeedsAnimals': _specialNeedsAnimals
            .map((specialAnimal) => specialAnimal.toJSON())
            .toList(),
      };

  List<CompromisedAnimal> get compromisedAnimals =>
      List.unmodifiable(_compromisedAnimals);

  List<CompromisedAnimal> get specialNeedsAnimals =>
      List.unmodifiable(_specialNeedsAnimals);

  String _compromisedAnimalsToString() => _compromisedAnimals.isEmpty
      ? 'N/A'
      : _compromisedAnimals
          .map((animal) => animal.toString())
          .toList()
          .join(",");

  String _specialNeedsAnimalsToString() => _specialNeedsAnimals.isEmpty
      ? 'N/A'
      : _specialNeedsAnimals
          .map((animal) => animal.toString())
          .toList()
          .join(",");

  String toString() => '''Animal(s) description:
  Species: $species, Group age: $groupAge, Approximate weight: $approximateWeight
  Purpose: $animalPurpose, Number of animals: $numberAnimals
  Are all animals fit for transport?: ${animalsFitForTransport ? 'Yes' : 'No'}
  Number of compromised animals loaded: ${_compromisedAnimals.length}
  Compromised animal(s), identification description and measures taken: ${_compromisedAnimalsToString()}
  Number of animal(s) with special needs: ${_specialNeedsAnimals.length}
  Special needs animal(s), identification description and measures taken: ${_specialNeedsAnimalsToString()}''';

  List<Widget> _compromisedAnimalsToWidget() => _compromisedAnimals.isEmpty
      ? [
          ListTile(
              visualDensity: VisualDensity(horizontal: 0, vertical: -2),
              title: Text("N/A"))
        ]
      : _compromisedAnimals.map((animal) => animal.toWidget()).toList();

  List<Widget> _specialNeedsAnimalsToWidget() => _specialNeedsAnimals.isEmpty
      ? [
          ListTile(
              visualDensity: VisualDensity(horizontal: 0, vertical: -2),
              title: Text("N/A"))
        ]
      : _specialNeedsAnimals.map((animal) => animal.toWidget()).toList();

  Widget toWidget() {
    final List<Widget> fields = [
      ListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -2),
          title: Text("Animal(s) description")),
      ListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -2),
          title: Text("Species"),
          subtitle: Text(species)),
      ListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -2),
          title: Text("Group age"),
          subtitle: Text('$groupAge')),
      ListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -2),
          title: Text("Approximate weight"),
          subtitle: Text('$approximateWeight')),
      ListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -2),
          title: Text("Purpose"),
          subtitle: Text(animalPurpose)),
      ListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -2),
          title: Text("Number of animals"),
          subtitle: Text('$numberAnimals')),
      ListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -2),
          title: Text("Are all animals fit for transport?"),
          subtitle: Text(' ${animalsFitForTransport ? 'Yes' : 'No'}')),
      ListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -2),
          title: Text("Number of compromised animals loaded"),
          subtitle: Text('${_compromisedAnimals.length}')),
      ListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -2),
          title: Text(
              "Compromised animal(s), identification description and measures taken")),
    ];
    final List<Widget> specialNeedsFields = [
      ListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -2),
          title: Text("Number of animal(s) with special needs"),
          subtitle: Text('${_specialNeedsAnimals.length}')),
      ListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -2),
          title: Text(
              "Special needs animal(s), identification description and measures taken")),
    ];

    fields.addAll(_compromisedAnimalsToWidget());
    fields.addAll(specialNeedsFields);
    fields.addAll(_specialNeedsAnimalsToWidget());
    return Column(children: fields);
  }
}

@immutable
class CompromisedAnimal {
  final String animalDescription;
  final String measuresTakenToCareForAnimal;

  CompromisedAnimal(
      {@required this.animalDescription,
      @required this.measuresTakenToCareForAnimal});

  @override
  int get hashCode =>
      animalDescription.hashCode ^ measuresTakenToCareForAnimal.hashCode;

  @override
  bool operator ==(other) {
    return (other is CompromisedAnimal) &&
        other.animalDescription == animalDescription &&
        other.measuresTakenToCareForAnimal == measuresTakenToCareForAnimal;
  }

  CompromisedAnimal.fromJSON(Map<String, dynamic> json)
      : animalDescription = json['animalDescription'],
        measuresTakenToCareForAnimal = json['measuresTakenToCareForAnimal'];

  Map<String, dynamic> toJSON() => {
        'animalDescription': animalDescription,
        'measuresTakenToCareForAnimal': measuresTakenToCareForAnimal,
      };

  String toString() => '''$animalDescription
  $measuresTakenToCareForAnimal''';

  Widget toWidget() => ListTile(
      visualDensity: VisualDensity(horizontal: 0, vertical: -2),
      title: Text(animalDescription),
      subtitle: Text(measuresTakenToCareForAnimal));
}
