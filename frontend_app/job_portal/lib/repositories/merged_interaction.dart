import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:job_portal/models/merged_interaction.dart';

class MergedInteractionRepository {
  static Future<List<MergedInteraction>> fetAllInteraction(
      int applicantId) async {
    String url;
    url = "http://10.0.2.2:8088/api/v1/mergedInteraction/$applicantId";
    final response = await http.get(
      Uri.parse(url),
    );
    if (response.statusCode == 200) {
      final String utf8Body = utf8.decode(response.bodyBytes);
      List<dynamic> data = jsonDecode(utf8Body);
      List<MergedInteraction> allIteraction =
          data.map((job) => MergedInteraction.fromJson(job)).toList();
      return allIteraction;
    } else {
      throw Exception('Failed to load allInteraction');
    }
  }
}
