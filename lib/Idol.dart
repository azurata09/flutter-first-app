import 'dart:convert';

import 'package:http/http.dart' as http;

Future<List<Idol>> fetchIdols() async {
  const QUERY = '''
PREFIX schema: <http://schema.org/>
PREFIX imas: <https://sparql.crssnky.xyz/imasrdf/URIs/imas-schema.ttl#>

SELECT ?name ?color
WHERE {
  ?s schema:name | schema:alternateName ?name;
       imas:Color ?color.
  FILTER REGEX(lang(?name), "ja")
}
''';

  final response = await http.get(Uri.https(
      'sparql.crssnky.xyz',
      '/spql/imas/query',
      {'output': 'json', 'force-accept': 'text/plain', 'query': QUERY}));

  if (response.statusCode == 200) {
    var json = await jsonDecode(response.body);
    return (json['results']['bindings'] as List)
        .map<Idol>((row) => Idol.fromJson(row as Map<String, dynamic>))
        .toList();
  } else {
    throw Exception('Failed to load idol in outside');
  }
}

class Idol {
  final String name;
  final String color;

  // constructor
  const Idol({required this.name, required this.color});

  factory Idol.fromJson(Map<String, dynamic> json) {
    final name = json['name']['value'];
    final color = json['color']['value'];

    final result = Idol(name: name, color: color);
    return result;
  }
}
