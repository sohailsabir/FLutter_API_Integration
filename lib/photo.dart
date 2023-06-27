import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_api_integration/Model/PostList.dart';
import 'package:http/http.dart'as http;

class Photo extends StatefulWidget {
  const Photo({Key? key}) : super(key: key);

  @override
  _PhotoState createState() => _PhotoState();
}

class _PhotoState extends State<Photo> {
List<PhotoModel> photoList=[];
Future<List<PhotoModel>>getPhotoList()async{
  final response=await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
  var data=jsonDecode(response.body.toString());
  print(data);
  print(response.statusCode);
  if(response.statusCode==200)
    {
      for(Map i in data)
        {
          PhotoModel photo=PhotoModel(id: i['id'], title: i['title'], url: i['url']);
          photoList.add(photo);
        }
      return photoList;
    }
  else{
    return photoList;
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
            future: getPhotoList(),
            builder: (context,AsyncSnapshot snapshot){
              if(!snapshot.hasData)
              {
                return Center(child: CircularProgressIndicator(),);
              }
              else{
                return ListView.builder(
                    itemCount: photoList.length,
                    itemBuilder: (context, index){
                      return Card(
                        child: ListTile(
                         leading: CircleAvatar(
                           backgroundImage: NetworkImage(snapshot.data![index].url.toString()),
                         ),
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
class PhotoModel{
  String title,url;
  int id;
  PhotoModel({required this.id,required this.title,required this.url});
}
