import 'package:json_annotation/json_annotation.dart';

import 'location_fact.dart';

part 'location.g.dart';

@JsonSerializable()
class Location {
  final String name;
  final String url;
  final List<LocationFact> facts;

  Location({this.name, this.url, this.facts}); // {} optional params

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);
}
