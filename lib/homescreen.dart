import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_api_integration/Model/PostList.dart';
import 'package:http/http.dart'as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<PostList> postList=[];
  Future<List<PostList>>getPostList()async{
    print('Ok');
    final response=await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var data=jsonDecode(response.body.toString());
    print(response.statusCode);
    print(data);
    if(response.statusCode==200)
      {
        postList.clear();
        for(Map i in data){
          postList.add(PostList.fromJson(i));
        }
        print(postList);
        return postList;
      }
    else{
      print("Nahi");
        return postList;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('API Integration'),
      centerTitle: true,),
      body: Column(
        children: [
          Expanded(child: FutureBuilder(
            future: getPostList(),
            builder: (context,snapshot){
              if(!snapshot.hasData)
                {
                  return Center(child: CircularProgressIndicator(),);
                }
              else{
                return ListView.builder(
                  itemCount: postList.length,
                    itemBuilder: (context, index){
                    return Card(
                      child: ListTile(
                          title: Text("Title: ${postList[index].title}"),
                        subtitle: Text('Description: ${postList[index].body}'),
                      ),
                    );
                    });
              }
            },
          ))
        ],
      ),
    );
  }
}
