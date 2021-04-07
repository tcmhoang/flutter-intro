import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../endpoint.dart';
import 'location_fact.dart';

import 'package:http/http.dart' as http;

part 'location.g.dart';

@JsonSerializable()
class Location {
  final int id;
  final String name;
  final String url;
  final List<LocationFact> facts;

  Location({this.id, this.name, this.url, this.facts}); // {} optional params

  Location.blank()
      : id = 0,
        name = '',
        url = '',
        facts = [];

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  static Future<List<Location>> fetchAll() async {
    var uri = Endpoint.uri('/locations');

    final resp = await http.get(uri);

    if (resp.statusCode != 200) {
      throw (resp.body);
    }
    List<Location> list = [];
    for (var jsonItem in json.decode(resp.body)) {
      list.add(Location.fromJson(jsonItem));
    }
    return list;
  }

  static Future<Location> fetchByID(int id) async {
    var uri = Endpoint.uri('/locations/$id');

    final resp = await http.get(uri);

    if (resp.statusCode != 200) {
      throw (resp.body);
    }
    final Map<String, dynamic> itemMap = json.decode(resp.body);
    return Location.fromJson(itemMap);
  }

  static Future<Location> fetchAny() async {
    return Location.fetchByID(1);
  }
}
