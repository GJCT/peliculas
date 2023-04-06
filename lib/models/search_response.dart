// To parse this JSON data, do
//
//     final searchResponse = searchResponseFromJson(jsonString);
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:peliculas/models/models.dart';

class SearchResponse {
    SearchResponse({
        @required this.page,
        @required this.results,
        @required this.totalPages,
        @required this.totalResults,
    });

    int page;
    List<Movie> results;
    int totalPages;
    int totalResults;

    factory SearchResponse.fromJson(String str) => SearchResponse.fromMap(json.decode(str));

    //String toRawJson() => json.encode(toJson());

    factory SearchResponse.fromMap(Map<String, dynamic> json) => SearchResponse(
        page: json["page"],
        results: List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
    );
}
