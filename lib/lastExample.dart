import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_api_integration/Model/PostList.dart';

import 'package:http/http.dart'as http;

import 'Model/product.dart';

class LastExample extends StatefulWidget {
  const LastExample({Key? key}) : super(key: key);

  @override
  _LastExampleState createState() => _LastExampleState();
}

class _LastExampleState extends State<LastExample> {

  Future<ProductsModel> getProductsApi () async {

    final response = await http.get(Uri.parse('https://webhook.site/2217c9f5-ff21-4bb8-acd4-eccf2df8d080'));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      return ProductsModel.fromJson(data);
    }else {
      return ProductsModel.fromJson(data);

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
            future: getProductsApi(),
            builder: (context,snapshot){
              if(!snapshot.hasData)
              {
                return Center(child: CircularProgressIndicator(),);
              }
              else{
                return ListView.builder(
                    itemCount: snapshot.data!.data!.length,
                    itemBuilder: (context, index){
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            title: Text(snapshot.data!.data![index].shop!.name.toString()),
                            subtitle: Text(snapshot.data!.data![index].shop!.shopemail.toString()),
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(snapshot.data!.data![index].shop!.image.toString()),
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height*.26,
                            width: MediaQuery.of(context).size.width*1,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data!.data![index].images!.length,
                                itemBuilder: (context,postion){
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: MediaQuery.of(context).size.height*.25,
                                      width: MediaQuery.of(context).size.width*.5,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        image: DecorationImage(
                                          image: NetworkImage(snapshot.data!.data![index].images![postion].url.toString()),
                                          fit: BoxFit.fill
                                        )
                                      ),
                                    ),
                                  );
                                }
                            ),
                          ),
                        ],
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
