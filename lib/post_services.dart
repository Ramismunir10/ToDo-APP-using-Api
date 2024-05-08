import 'dart:convert';

import 'package:http/http.dart' as http;

class PostService {
  String baseUrl =
      "https://crudcrud.com/api/bb088476c0364ff6b9ab1a224f0273c9/unicorns/";

  Future<List> getPosts() async {
    try {
      var response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        // return a decoded body
        return jsonDecode(response.body);
      } else {
        // server error
        return Future.error("Server Error !");
      }
    } catch (SocketException) {
      // fetching error
      // may be timeout, no internet or dns not resolved
      return Future.error("Error Fetching Data !");
    }
  }

  Future<String> createPost(Map<String, dynamic> data) async {
    try {
      var response = await http.post(
        Uri.parse("$baseUrl/create"),
        body: jsonEncode(data),
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
        },
      );
      if (response.statusCode == 200) {
        return "success";
      } else {
        //print(response.body);
        // server error
        return "err";
      }
    } catch (SocketException) {
      // fetching error
      return "err";
    }
  }

   Future<String> deletePost(Map<String, dynamic> data) async {
     try {
       var response = await http.delete(
         Uri.parse("$baseUrl/delete"),
         body: jsonEncode(data),
         headers: {
           "Content-Type": "application/json; charset=UTF-8",
         },
       );
       //
       if (response.statusCode == 200) {
         return "success";
       } else {
         print(response.body);
         // server error
         return "err";
       }
     } catch (SocketException) {
       // fetching error
       return "err";
     }
   }
}
