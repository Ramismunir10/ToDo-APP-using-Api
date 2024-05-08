// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   getPostApi() async {
//     var url = Uri.parse('https://crudcrud.com/api/28ddbe69f83246319d40bb64c2833df1/unicorns');
//     var response = await http.get(url);
//     var responsebody = jsonDecode(response.body);
//     return responsebody;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FutureBuilder(
//         future: getPostApi(),
//         builder: (context, AsyncSnapshot snapshot) {
//           return ListView.builder(
//             itemCount: snapshot.data!.length,
//             itemBuilder: (context, index) {
//               return ListTile(
//                 title: Text(snapshot.data[index]['Task'].toString()),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
