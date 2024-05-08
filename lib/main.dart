import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todoapi/post_services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(primarySwatch: Colors.purple),
        home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PostService postService = PostService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ToDo App"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          String? title;
          String? _id;
          String? content;
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              content: Form(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[200],
                          labelText: "Title"),
                      onChanged: (_val) {
                        title:
                        _val;
                      },
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[200],
                          labelText: "Content"),
                      onChanged: (_val) {
                        content:
                        _val;
                      },
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          _id = title?.split(" ").join("-");
                          Map<String, dynamic> data = {
                            "title": title,
                            "_id": _id,
                            "content": content
                          };
                          //make response
                          String res = await postService.createPost(data);
                          //wait for response
                          //make toast
                          res == "success"
                              ? Fluttertoast.showToast(
                                  msg: "Post Created Successfully !")
                              : Fluttertoast.showToast(
                                  msg: "Error Creating Post !");
                          Navigator.of(context).pop();
                          setState(() {});
                        },
                        child: Text("Add"))
                  ],
                ),
              ),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
      body: FutureBuilder<List>(
          future: postService.getPosts(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data?.length == 0) {
                return Center(
                  child: Text("No Posts Available !"),
                );
              }
              return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(snapshot.data?[index]["title"]),
                    subtitle: Text(snapshot.data?[index]["content"]),
                    trailing: IconButton(
                        onPressed: () async {
                          Map<String, dynamic> data = {
                            "_id": snapshot.data?[index]['_id']
                          };
                          var res = await postService.deletePost(data);
                          res == "success"
                              ? Fluttertoast.showToast(
                                  msg: "Post Deleted Successfully !")
                              : Fluttertoast.showToast(
                                  msg: "Error Deleting Post !");
                          Navigator.of(context).pop();
                          setState(() {});
                        },
                        icon: Icon(Icons.delete)),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
