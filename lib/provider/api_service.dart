import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  final String UrlAppend;
  final String baseUrl = 'http://192.168.0.9:8000/api/v2/';  // Substitua pelo endereço apropriado
  //otavio
    //'http://192.168.0.53:8000/api/v2/'

    //kyu daonde?
    //'http://192.168.0.5:8000/api/v2/

    //kyu são carlos pc
    //'http://192.168.0.9:8000/api/v2/'

    //kyu pedreira
    //'http://192.168.15.108:8000/api/v2/'
    
  ApiService({required this.UrlAppend});

  Future<List<dynamic>> fetchData() async {
    final response = await http.get(Uri.parse('$baseUrl$UrlAppend'));

    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<dynamic> fetchDataById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl$UrlAppend$id/'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data for id $id');
    }
  }

  Future<List<dynamic>> fetchMemberDetails(List<int> ids) async {
    List<dynamic> memberDetails = [];
    for (int id in ids) {
      try {
        final memberDetail = await fetchDataById(id);
        memberDetails.add(memberDetail);
      } catch (error) {
        print('Failed to load member detail for id $id: $error');
      }
    }
    return memberDetails;
  }
}
