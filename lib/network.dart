import 'dart:convert';

import 'package:http/http.dart' as http;


getCurrencyExchangeRate(String base,String target) async{
var url = Uri.https('exchange-rates.abstractapi.com', '/v1/live/',{'api_key':'5d274d3a5938472c84aaa9542b4f336a','base':base,'target':target});
var response = await http.get(url);
print('Response status: ${response.statusCode}');
print('Response body: ${response.body}');
return jsonDecode(response.body);
}
