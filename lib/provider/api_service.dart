import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  final String UrlAppend;

  ApiService({required this.UrlAppend});

  Future<List<dynamic>> fetchData() async {
                                              /* Subsitua por http://(seu indereço de ip):8000*/
    //otavio
    //final response = await http.get(Uri.parse('http://192.168.0.53:8000/api/v2/$UrlAppend'));

    //kyu
    //final response = await http.get(Uri.parse('http://192.168.0.5:8000/api/v2/$UrlAppend'));
    
    //kyu pedreira
    
    final response = await http.get(Uri.parse('http://192.168.15.108:8000/api/v2/$UrlAppend'));
    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
